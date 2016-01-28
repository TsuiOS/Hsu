//
//  StatusViewModel.swift
//  HsuSina
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import Foundation

/// 单条微博视图模型
class StatusViewModel {
    
    ///  微博模型
    var status: XNStatus
    
    ///  构造函数
    init(status: XNStatus) {
        self.status = status
    
    }
    
}