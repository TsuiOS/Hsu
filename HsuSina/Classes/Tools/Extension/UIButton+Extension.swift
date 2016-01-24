//
//  UIButton+Extension.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

extension UIButton {

/// 便利构造函数
    convenience init(imageName: String, backgroundImageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        setBackgroundImage(UIImage(named: backgroundImageName), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), forState: UIControlState.Highlighted)
        // 会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    
}
