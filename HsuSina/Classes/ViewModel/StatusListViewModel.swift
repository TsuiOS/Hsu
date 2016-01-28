//
//  StatusesViewModel.swift
//  HsuSina
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import Foundation

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

        }

    }
    
}