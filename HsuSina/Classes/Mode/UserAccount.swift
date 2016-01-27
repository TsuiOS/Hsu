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
    
    // MARK : - 保存当前对象
    func saveUserAccount() {
        //1. 保存路径
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        
        path = (path as NSString).stringByAppendingPathComponent("account.plist")
        
        print(path)
        // 归档保存
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
    
    }
    // MARK : - 归档和解档
    ///  归档
    ///
    ///  - parameter aCoder: 编码器
    func encodeWithCoder(aCoder: NSCoder) {
    
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expiresDate, forKey: "expiresDate")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        
    
    }
    ///  解档
    ///
    ///  - parameter aDecoder: 解码器
    ///
    ///  - returns: 当前对象
    required init(coder aDecoder: NSCoder) {
    
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
        uid = aDecoder.decodeObjectForKey("uid") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String

    }
    
}
