//
//  XNStatusPictureView.swift
//  HsuSina
//
//  Created by mac on 16/1/30.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SDWebImage
/// 照片之间的间距
private let StatusPictureViewItemMargin: CGFloat = 8
/// 可重用表示符号
private let StatusPictureCellId = "StatusPictureCellId"

class XNStatusPictureView: UICollectionView {
    
    //// 微博视图模型
    var viewModel: StatusViewModel? {
        didSet {
            // 自动计算大小
            sizeToFit()
            // 刷新数据
            reloadData()
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return calcViewSize()

    }
    
    // MARK : - 构造函数
    init() {
        let layout = UICollectionViewFlowLayout()
        
        // 设置间距
        layout.minimumInteritemSpacing = StatusPictureViewItemMargin
        layout.minimumLineSpacing = StatusPictureViewItemMargin
        
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        // 设置数据源
        //自己当自己的数据源
        dataSource = self
        //设置代理
        delegate = self
        
        // 注册可重用 cell
        registerClass(StatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureCellId)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UICollectionViewDataSource
extension XNStatusPictureView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    ///  选中图片
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("点击照片 \(indexPath) \(viewModel?.thumbnailUrls)")
        
        // 通知：名字(通知中心监听)/object：发送通知的同时传递对象(单值)/ userInfo 传递多值的时候，使用的数据字典 -> Key
        let userInfo = [XNStatusSelectedPhotoIndexPathKey: indexPath,
            XNStatusSelectedPhotoURLsKey: viewModel!.thumbnailUrls!]
        
        NSNotificationCenter.defaultCenter().postNotificationName(XNStatusSelectedPhotoNotification,
            object: self,
            userInfo: userInfo)
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnailUrls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StatusPictureCellId, forIndexPath: indexPath) as! StatusPictureViewCell
        cell.imageURL = viewModel?.thumbnailUrls![indexPath.item]
        
        return cell
        
    }
}

// MARK: - 计算视图大小
extension XNStatusPictureView {
    
    ///  计算视图大小
    private func calcViewSize() -> CGSize {
    
        // 1.准备
        // 每行照片数量
        let rowCount: CGFloat = 3
        // 最大宽度
        let maxWith = UIScreen.mainScreen().bounds.width - 2 * StatusCellMargin
        let itemWith = (maxWith - 2 * StatusPictureViewItemMargin) / rowCount
        
        //2. 设置 layout 的 itemSize
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWith, height: itemWith)
        
        //3. 获取图片的数量
        let count = viewModel?.thumbnailUrls?.count ?? 0
        
        //4. 计算大小
        //1> 没有配图
        if count == 0 {
            return CGSizeZero
        }
        
        //2> 一张配图
        if count == 1 {
            // 暂时指定大小
            var size = CGSize(width: 150, height: 120)
            
            // 利用 SDWebImage 检查本地的缓存图像
            // 命名规则 完整 url 字符串 -> MD5
            if let key = viewModel?.thumbnailUrls?.first?.absoluteString {
            
                print("----\(key)")
                let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
                size = image.size
            
            }
            // 过窄处理
            size.width = size.width < 40 ? 40 : size.width
            
            //过宽的图片
            if size.width > 300 {
                let w: CGFloat = 300
                let h = size.height * w / size.width
                
                size = CGSize(width: w, height: h)
            
            }
            
            //设置内部图片的大小
            layout.itemSize = size
            
            //设置配图的大小
            return size
        }
        
        //3> 四张配图 2*2 
        if count == 4 {
            let with = 2 * itemWith + StatusPictureViewItemMargin
            return CGSize(width: with, height: with)
        }
        // 4> 其他的情况
        let row = ceil(CGFloat(count) / rowCount)
        let h = row * itemWith + (row - 1) * StatusPictureViewItemMargin
        let w = maxWith
        
        return CGSize(width: w, height: h)
        
    }

}

private class StatusPictureViewCell: UICollectionViewCell {
    
    var imageURL: NSURL? {
        didSet {
            iconView.sd_setImageWithURL(imageURL,
                placeholderImage: nil,
                options: [])
            //SDWebImageOptions.RetryFailed,SDWebImageOptions.RefreshCached
        }
    }
    
    // MARK : - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //1 添加控件
        contentView.addSubview(iconView)
        
        //2. 设置布局
        iconView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
    
    
    }
    
    // MARK : - 懒加载控件
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        
        //设置填充模式
        iv.contentMode = UIViewContentMode.ScaleAspectFill
        //需要裁剪图片
        iv.clipsToBounds = true
        
        return iv
    }()


}


