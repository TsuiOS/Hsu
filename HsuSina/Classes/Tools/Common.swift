//
//  Common.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
/// 切换根视图控制器通知
let XNSwitchRootViewControllerNotification = "XNSwitchRootViewControllerNotification"

/// 选中照片通知
let XNStatusSelectedPhotoNotification = "XNStatusSelectedPhotoNotification"
/// 选中照片的 KEY - IndexPath
let XNStatusSelectedPhotoIndexPathKey = "XNStatusSelectedPhotoIndexPathKey"
/// 选中照片的 KEY - URL 数组
let XNStatusSelectedPhotoURLsKey = "XNStatusSelectedPhotoURLsKey"


/// 全局外观渲染颜色
let XNAppearanceTintColor = UIColor.orangeColor()

/// 延迟在主线程执行函数
///
/// - parameter delta:    延迟时间
/// - parameter callFunc: 要执行的闭包
func delay(delta: Double, callFunc: ()->()) {
    
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, Int64(delta * Double(NSEC_PER_SEC))),
        dispatch_get_main_queue()) {
            
            callFunc()
    }
}
