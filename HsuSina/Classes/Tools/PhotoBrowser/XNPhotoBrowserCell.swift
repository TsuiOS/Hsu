//
//  XNPhotoBrowserCell.swift
//  HsuSina
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SDWebImage

/// 照片查看 cell
class XNPhotoBrowserCell: UICollectionViewCell {
    
    var imageURL: NSURL? {
        didSet {
        
            guard let url = imageURL else {
                return
            }
            // 从磁盘中加载缩略图的图像
            imageView.image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url.absoluteString)
            // 设置大小
            imageView.sizeToFit()
            
            //设置中心点
            imageView.center = scrollView.center
            // 异步加载大图
            imageView.sd_setImageWithURL(bmiddleURL(url)) { (image, _, _, _) -> Void in
                // 设置图像视图的位置
                self.setPositon(image)
            }
            
        }
    }
    ///  设置 imageView 的位置
    ///
    ///  - parameter image: image
    private func setPositon(image: UIImage) {
        
        // 自动设置大小
        let size = self.displaySize(image)
        
        // 判断图片高度
        if size.height < scrollView.bounds.height {
            // 上下局中显示
            let y = (scrollView.bounds.height - size.height) * 0.5
            imageView.frame = CGRect(x: 0, y: y, width: size.width, height: size.height)
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            scrollView.contentSize = size
        }
    }
    /// 返回中等尺寸图片 URL
    ///
    /// - parameter url: 缩略图 url
    ///
    /// - returns: 中等尺寸 URL
    private func bmiddleURL(url: NSURL) -> NSURL {
        print(url)
        
        // 1. 转换成 string
        var urlString = url.absoluteString
        
        // 2. 替换单词
        urlString = urlString.stringByReplacingOccurrencesOfString("/thumbnail/", withString: "/bmiddle/")
        
        return NSURL(string: urlString)!
    }
    
    /// 根据 scrollView 的宽度计算等比例缩放之后的图片尺寸
    ///
    /// - parameter image: image
    ///
    /// - returns: 缩放之后的 size
    private func displaySize(image: UIImage) -> CGSize {
        
        let w = scrollView.bounds.width
        let h = image.size.height * w / image.size.width
        
        return CGSize(width: w, height: h)
    }
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 1. 添加控件
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        // 2. 设置位置
        scrollView.frame = bounds
    }

    
    // MARK : - 懒加载控件
    private lazy var scrollView: UIScrollView = UIScrollView()
    private lazy var imageView: UIImageView = UIImageView()
}
