//
//  UserAccount.swift
//  HsuSina
//
//  Created by mac on 16/1/26.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

///  用户账户模型
class UserAccount: NSObject {

//    {
//    "access_token": "ACCESS_TOKEN",用于调用access_token，接口获取授权后的access token
//    "expires_in": 1234,access_token的生命周期，单位是秒数。
//    "remind_in":"798114",access_token的生命周期
//    "uid":"12341234"当前授权用户的UID
//    }
    /// 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    /// access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0
    /// 当前授权用户的UID
    var uid: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        
        let keys = ["access_token", "expires_in", "uid"]
        
        return dictionaryWithValuesForKeys(keys).description
    }

}
