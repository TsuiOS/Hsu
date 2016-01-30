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
    ///  - parameter title:             title
    ///  - parameter color:             color
    ///  - parameter backgroundImage:   背景图像
    ///
    ///  - returns: UIButton
    convenience init(title: String, color: UIColor,backgroundImage: String) {
        self.init()
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        setBackgroundImage(UIImage(named: backgroundImage), forState: .Normal)
        
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter color:     color
    /// - parameter fontSize:  字体大小
    /// - parameter imageName: 图像名称
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        setImage(UIImage(named: imageName), forState: .Normal)
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        sizeToFit()
    }
    
}
