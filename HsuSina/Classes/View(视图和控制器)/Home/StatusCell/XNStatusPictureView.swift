//
//  XNStatusPictureView.swift
//  HsuSina
//
//  Created by mac on 16/1/30.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

/// 照片之间的间距
private let StatusPictureViewItemMargin: CGFloat = 8

class XNStatusPictureView: UICollectionView {
    
    //// 微博视图模型
    var viewModel: StatusViewModel? {
        didSet {
            // 自动计算大小
            sizeToFit()
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        print(calcViewSize())
        return calcViewSize()
//        return CGSize(width: 200, height: 90 * (random() % 4))

    }
    
    // MARK : - 构造函数
    init() {
        let layout = UICollectionViewFlowLayout()
        
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            let size = CGSize(width: 150, height: 120)
            
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
        let row = CGFloat((count - 1) / Int(rowCount) + 1)//ceil(CGFloat(count) / rowCount)
        let h = row * itemWith + (row - 1) * StatusPictureViewItemMargin
        let w = maxWith
        
        return CGSize(width: w, height: h)
        
    }

}

