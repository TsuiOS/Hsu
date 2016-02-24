//
//  XNPhotoBrowserCell.swift
//  HsuSina
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
/// 照片查看 cell
class XNPhotoBrowserCell: UICollectionViewCell {
    
    var imageURL: NSURL? {
        didSet {
        
            guard let url = imageURL else {
                return
            }
            // 恢复 scrollView
            resetScrollView()
            
            // 从磁盘中加载缩略图的图像
            //会先从磁盘中找,如果没有才走网络加载
            let placeholderImage = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url.absoluteString)

            // 设置占位图片
            setPlaceHolder(placeholderImage)
            
            imageView.sd_setImageWithURL(bmiddleURL(url),
                placeholderImage: nil,
                options: [SDWebImageOptions.RefreshCached,SDWebImageOptions.RetryFailed],
                progress: { (current, total) -> Void in
                    // 回到主线程更新 UI
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.placeHolder.progress = CGFloat(current) / CGFloat(total)
                        print("----- \(self.placeHolder.progress)")
                    })
                   
                }) { (image, _, _, _) -> Void in
                    
                    // 判断图像下载时候成功
                    if image == nil {
                        SVProgressHUD.showInfoWithStatus("您的网络不给力")
                    }
                    self.placeHolder.hidden = true
                    // 设置图像视图的位置
                    self.setPositon(image)
            }
        }
    }
    ///  设置占位图像内容的视图
    ///
    ///  - parameter image: 本地缓存的缩略图,如果下载失败, image 为nil
    private func setPlaceHolder(image: UIImage?) {
        
        self.placeHolder.hidden = false
        
        placeHolder.image = image
        placeHolder.sizeToFit()
        placeHolder.center = scrollView.center
    
    }
    ///  重设 scrollView 的内容属性
    private func resetScrollView() {
        // 重设 imageview 的内容属性
        imageView.transform = CGAffineTransformIdentity
        
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.contentOffset = CGPointZero
        scrollView.contentSize = CGSizeZero
    
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
            imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            scrollView.contentInset = UIEdgeInsets(top: y, left: 0, bottom: 0, right: 0)
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
        scrollView.addSubview(placeHolder)
        
        // 2. 设置位置
        var rect = bounds
        rect.size.width -= 20
        scrollView.frame = rect
        
        // 3. 设置 scrollview 缩放
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
    
    }
    
    // MARK : - 懒加载控件
    private lazy var scrollView: UIScrollView = UIScrollView()
    private lazy var imageView: UIImageView = UIImageView()
    private lazy var placeHolder: XNProgressImageView = XNProgressImageView()
}

// MARK: - UIScrollViewDelegate
extension XNPhotoBrowserCell: UIScrollViewDelegate {

    ///  返回被缩放的视图
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    ///  缩放完成之后执行一次
    ///
    ///  - parameter scrollView: scrollView
    ///  - parameter view:       view 被缩放的视图
    ///  - parameter scale:      被缩放的比例
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        print("缩放完成 \(view) \(view?.bounds)")
        
        var offsetY = (scrollView.bounds.height - view!.frame.height) * 0.5
        offsetY = offsetY < 0 ? 0 : offsetY
        
        var offsetX = (scrollView.bounds.width - view!.frame.width) * 0.5
        offsetX = offsetX < 0 ? 0 : offsetX
        
        // 设置间距
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)

    }
    ///  只要缩放就会调用
    /**
    a d => 缩放比例
    a b c d => 共同决定旋转
    tx ty => 设置位移
    
    定义控件位置 frame = center + bounds * transform
    */
    func scrollViewDidZoom(scrollView: UIScrollView) {
        print(imageView.transform)
    }
}
