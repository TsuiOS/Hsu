//
//  UIImageView+Extension.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

extension UIImageView {
    
    ///  构造便利函数
    ///
    ///  - parameter imageName: imageName
    ///
    ///  - returns: UIImageView
    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName))
    
    }

}
