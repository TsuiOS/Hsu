//
//  Emoticon.swift
//  01-表情键盘
//
//  Created by male on 15/10/23.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

// MARK: - 表情模型
class Emoticon: NSObject {
    /// 发送给服务器的表情字符串
    var chs: String?
    /// 在本地显示的图片名称 + 表情包路径
    var png: String?
    
    /// 完整的路径
    var imagePath: String {
        
        // 判断是否有图片
        if png == nil {
            return ""
        }
        
        // 拼接完整路径
        return NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + png!
    }
    
    /// emoji 的字符串编码
    var code: String? {
        didSet {
            emoji = code?.emoji
        }
    }
    /// emoji 的字符串
    var emoji: String?
    /// 是否删除按钮标记
    var isRemoved = false
    /// 是否空白按钮标记
    var isEmpty = false
    
    // MARK: - 构造函数
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
        
        super.init()
    }
    
    init(isRemoved: Bool) {
        self.isRemoved = isRemoved
        
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["chs", "png", "code", "isRemoved"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
}
