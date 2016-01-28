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
}

// MARK : - 新特性 cell
private class XNNewFeatureCell: UICollectionViewCell {
    
    ///  图像属性
    private var imageIndex: Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            print("new_feature_\(imageIndex + 1)")
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
    
    
    }
    // MARK : - 懒加载控件
    /// 图像
    private lazy var iconView: UIImageView = UIImageView()
    ///  开始按钮
    private lazy var startButton: UIButton = UIButton(title: "开始体验", color:  UIColor.whiteColor(), imageName: "new_feature_finish_button")

}
