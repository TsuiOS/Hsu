//
//  XNPhotoBrowserViewController.swift
//  HsuSina
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SVProgressHUD
/// 可重用 Cell 标示符号
private let PhotoBrowserViewCellId = "PhotoBrowserViewCellId"

class XNPhotoBrowserViewController: UIViewController {

    ///  照片 url 数组
    private var urls: [NSURL]
    ///  当前选中的照片索引
    private var currentIndexPath: NSIndexPath
    
    // MARK: - 监听方法
    @objc private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 保存照片
    @objc private func save() {
        //1 拿到图片
        let cell = collectionView.visibleCells()[0] as! XNPhotoBrowserCell
        // imageView 中很可能会因为网络问题没有图片
        guard let image = cell.imageView.image else {
            return
        }
        //保存图像
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
       
    }
     //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?) {
        
        let message = (error == nil) ? "保存成功" : "保存失败"
        SVProgressHUD.showInfoWithStatus(message)
        
    }

    // MARK : - 构造函数
    init(urls: [NSURL], indexPath: NSIndexPath) {
        self.urls = urls
        self.currentIndexPath = indexPath
        
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // loadView 函数执行完毕, view 上的元素要全部加载完成
    override func loadView() {
        var rect = UIScreen.mainScreen().bounds
        rect.size.width += 20
        //1. 设置根视图
        view = UIView(frame: rect)
        
        //2. 设置界面
        setupUI()
    }
    
    // 是视图加载完成后被调用, loadView 执行完毕被执行
    // 主要做数据加载或者其他处理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //让 collection 滚动到指定的位置
        collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: .CenteredHorizontally, animated: false)
    }

    // MARK : - 懒加载控件
    private lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserViewLayout())
    /// 关闭按钮
    private lazy var closeButton: UIButton = UIButton(title: "关闭", fontSize: 14, color: UIColor.whiteColor(), imageName: nil, backColor: UIColor.darkGrayColor())
        /// 保存按钮
    private lazy var saveButton: UIButton = UIButton(title: "保存", fontSize: 14, color: UIColor.whiteColor(), imageName: nil, backColor: UIColor.darkGrayColor())
    
    // MARK: - 自定义流水布局
    private class PhotoBrowserViewLayout: UICollectionViewFlowLayout {
       
        private override func prepareLayout() {
            super.prepareLayout()
            
            itemSize = collectionView!.bounds.size
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            scrollDirection = .Horizontal
            
            collectionView?.pagingEnabled = true
            collectionView?.bounces = false
            
            collectionView?.showsHorizontalScrollIndicator = false
        }
    }
}
// MARK: - 设置 UI
private extension XNPhotoBrowserViewController {

    private func setupUI() {
    
        // 1. 添加控件
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        // 2. 设置布局
        collectionView.frame = view.bounds
        
        closeButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-8)
            make.left.equalTo(view.snp_left).offset(8)
            make.height.equalTo(36)
            make.width.equalTo(100)
        }
        saveButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-8)
            make.right.equalTo(view.snp_right).offset(-8)
            make.height.equalTo(36)
            make.width.equalTo(100)
        }
        
        // 3. 监听方法
        closeButton.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
        saveButton.addTarget(self, action: "save", forControlEvents: .TouchUpInside)
        
        // 4. 准备控件
        prepareCollectionView()
    }
    ///  准备 collectionView
    private func prepareCollectionView() {
        
        // 1. 准侧可重用 cell
        collectionView.registerClass(XNPhotoBrowserCell.self, forCellWithReuseIdentifier: PhotoBrowserViewCellId)
        
        // 2. 设置数据源
        collectionView.dataSource = self

    }

}
// MARK: - UICollectionViewDataSource
extension XNPhotoBrowserViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserViewCellId, forIndexPath: indexPath) as! XNPhotoBrowserCell
        
        cell.backgroundColor = UIColor.blackColor()
        
        cell.imageURL = urls[indexPath.item]
        
        return cell
    }

}