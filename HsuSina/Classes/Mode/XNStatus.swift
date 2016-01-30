//
//  XNStatus.swift
//  HsuSina
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

/// 微博数据模型
class XNStatus: NSObject {
    
    /// 微博 ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博创建时间
    var created_at: String?
    /// 缩略图配图数组 key: thumbnail_pic
    var pic_url: [String: String]?
    /// 微博来源
    var source: String?
    ///  用户模型
    var user: XNUser?

    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        //判断 key 是否是 user
        if key == "user" {
            if let dict = value as? [String: AnyObject] {
                user = XNUser(dict: dict)
            }
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["id", "text", "created_at", "source", "user","pic_url"]
        
        return dictionaryWithValuesForKeys(keys).description
    }

}
