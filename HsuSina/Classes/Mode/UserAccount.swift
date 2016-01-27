//
//  UserAccount.swift
//  HsuSina
//
//  Created by mac on 16/1/26.
//  Copyright © 2016年 Hsu. All rights reserved.
//

//    {
//    "access_token": "ACCESS_TOKEN",用于调用access_token，接口获取授权后的access token
//    "expires_in": 1234,access_token的生命周期，单位是秒数。
//    "remind_in":"798114",access_token的生命周期
//    "uid":"12341234"当前授权用户的UID
//    }
import UIKit

///  用户账户模型
class UserAccount: NSObject {


    /// 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    /// access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0 {
        //一旦从服务器获取到过期时间,就立刻计算准确的日期
        didSet {
            //计算过期日期
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        
        }
    }
    var expiresDate: NSDate?
    /// 当前授权用户的UID
    var uid: String?
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        
        let keys = ["access_token", "expires_in","expiresDate", "uid","screen_name","avatar_large"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
    
    
    

}
