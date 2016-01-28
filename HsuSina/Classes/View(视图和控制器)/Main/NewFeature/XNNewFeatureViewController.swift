//
//  XNNewFeatureViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

/// 可重用 cell id
private let XNCellReuseIdentifier = "XNCellReuseIdentifier"
 /// 新特性图像的数量
private let XNNewFeatureImageCount = 4

class XNNewFeatureViewController: UICollectionViewController {
    

    /// 构造函数
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        super.init(collectionViewLayout: layout)
        
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(XNNewFeatureCell.self, forCellWithReuseIdentifier: XNCellReuseIdentifier)

    }

    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return XNNewFeatureImageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(XNCellReuseIdentifier, forIndexPath: indexPath) as! XNNewFeatureCell
        
        cell.imageIndex = indexPath.item
    
        return cell
    }
    
    /// scrollView 停止滚动的方法
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        //判断是否是最后一页
        if page != XNNewFeatureImageCount - 1 {
            return
        }
        // 找到最后一个 cell
        let cell = collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! XNNewFeatureCell
        
        // 显示动画
        cell.showButtonAnim()
    }
    
}


// MARK : - 新特性 cell
private class XNNewFeatureCell: UICollectionViewCell {
    
    ///  图像属性
    private var imageIndex: Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            
            //隐藏按钮
            startButton.hidden = true
        }
    }
    
    /// 点击开始体验按钮
    @objc private func clickStartBtutton() {
        print("开始体验")
    }
    
    ///  显示动画按钮
    private func showButtonAnim() {
    
        startButton.hidden = false
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        //等待动画播放完毕之后交互
        startButton.userInteractionEnabled = false
        UIView.animateWithDuration(1.6,     //动画时长
            delay: 0,                       //延时时间
            usingSpringWithDamping: 0.6,    //弹力系数
            initialSpringVelocity: 10,      //初始速度
            options: [], animations: { () -> Void in
                self.startButton.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///  设置界面
    private func setupUI() {
        //添加控件
        addSubview(iconView)
        addSubview(startButton)
        
        //指定位置
        iconView.frame = bounds
        
        startButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.bottom.equalTo(self.snp_bottom).multipliedBy(0.7)
        }
        
        startButton.addTarget(self, action: "clickStartBtutton", forControlEvents: .TouchUpInside)
    
    
    }
    // MARK : - 懒加载控件
    /// 图像
    private lazy var iconView: UIImageView = UIImageView()
    ///  开始按钮
    private lazy var startButton: UIButton = UIButton(title: "开始体验", color:  UIColor.whiteColor(), imageName: "new_feature_finish_button")

}
