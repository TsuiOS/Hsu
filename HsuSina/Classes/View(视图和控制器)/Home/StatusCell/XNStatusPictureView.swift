//
//  XNStatusPictureView.swift
//  HsuSina
//
//  Created by mac on 16/1/30.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNStatusPictureView: UICollectionView {

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
