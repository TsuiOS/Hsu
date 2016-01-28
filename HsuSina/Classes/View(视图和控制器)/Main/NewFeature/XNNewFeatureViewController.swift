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
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: XNCellReuseIdentifier)

    }

    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return XNNewFeatureImageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(XNCellReuseIdentifier, forIndexPath: indexPath)
    
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.whiteColor() : UIColor.darkGrayColor()

    
        return cell
    }

    
}
