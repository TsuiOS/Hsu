//
//  UIButton+Extension.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

extension UIButton {

    ///  便利构造函数
    ///
    ///  - parameter imageName:           图片名称
    ///  - parameter backgroundImageName: 背景图片名称
    ///
    ///  - returns:  UIButton
    convenience init(imageName: String, backgroundImageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: .Normal)
        
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), forState: UIControlState.Highlighted)
        // 会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    
    ///  便利构造函数
    ///
    ///  - parameter title:     title
    ///  - parameter color:     color
    ///  - parameter imageName: imageName
    ///
    ///  - returns: UIButton
    convenience init(title: String, color: UIColor = UIColor.orangeColor(),imageName: String) {
        self.init()
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        setBackgroundImage(UIImage(named: imageName), forState: .Normal)
    
    }
    
}
