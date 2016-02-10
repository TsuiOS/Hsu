//
//  StatusesViewModel.swift
//  HsuSina
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import Foundation
import SDWebImage

/// 微博数据列表模型
class StatusListViewModel {
    
    ///  微博数据数组
    lazy var statusList = [StatusViewModel]()
    
    ///  加载网络数据
    func loadStatus(finished:(isSuccessed: Bool) -> ()) {
        
        NetworkTools.sharedTools.loadStatus { (result, error) -> () in
            if error != nil {
                print("出错啦")
                finished(isSuccessed: false)
                return
            }
            
            guard let array = result!["statuses"] as? [[String: AnyObject]] else {
                
                print("数据格式错误")
                finished(isSuccessed: false)
                return
            }
            /// 字典转模型
            //1. 可变的数组
            var dataList = [StatusViewModel]()
            
            //2 遍历数组
            for dict in array {
                dataList.append(StatusViewModel(status: XNStatus(dict: dict)))
            }
            
            //3. 拼接数据
            self.statusList = dataList + self.statusList
            
            //4. 完成的回调
            finished(isSuccessed: true)
            
            self.cacheSingleImage(dataList,finished: finished)

        }
    }
    
    ///  缓存单张图片
    private func cacheSingleImage(dataList: [StatusViewModel], finished: (isSuccessed: Bool)->()) {
    
        // 1. 创建调度组
        let group = dispatch_group_create()
        
        // 缓存收据长度
        var dataLength = 0
        
        for vm in dataList {
        
            // 判断图片数量是否是单张图片
            if vm.thumbnailUrls?.count != 1 {
                continue
            }
            // 获取 url
            let url = vm.thumbnailUrls![0]
            print("开始缓存图像 \(url)")
            //SDWebimage下载图像
            
            // 入组
            dispatch_group_enter(group)
            
            SDWebImageManager.sharedManager().downloadImageWithURL(url,
                options: [SDWebImageOptions.RefreshCached, SDWebImageOptions.RetryFailed],
                progress: nil,
                completed: { (image, _, _, _, _) -> Void in
                    
                    // 单张图片下载完成
                    if let img = image,
                        let data = UIImagePNGRepresentation(img){
                            
                            //累加二进制数据的长度
                            dataLength += data.length
                    }
                    // 出组
                    dispatch_group_leave(group)
            })
        }
        //3. 监听调度组完成
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            print("缓存完成 \(dataLength / 1024) K")
            
            // 完成回调 - 控制器才开始刷新表格
            finished(isSuccessed: true)
        }
    }
    
}