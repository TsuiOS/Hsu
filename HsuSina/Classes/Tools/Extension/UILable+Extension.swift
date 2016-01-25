//
//  UILable+Extension.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

extension UILabel {

    ///  便利构造函数
    ///
    ///  - parameter title:    标题
    ///  - parameter color:    color 默认darkGrayColor
    ///  - parameter fontSize: fontSize 默认14号
    ///
    ///  - returns: UILabel
    convenience init(title: String, color: UIColor = UIColor.darkGrayColor(),fontSize: CGFloat = 14) {
        self.init()
        text = title
        // 界面设计上,避免使用纯黑色
        textColor = color
        font = UIFont.systemFontOfSize(fontSize)
       
        numberOfLines = 0
        textAlignment = NSTextAlignment.Center
    }

}