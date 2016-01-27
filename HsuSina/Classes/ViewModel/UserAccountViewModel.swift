//
//  UserAccountViewModel.swift
//  HsuSina
//
//  Created by mac on 16/1/27.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import Foundation

/// 用户账户视图模型
class UserAccountViewModel {
    
    
    ///  单例
    static let sharedUserAccount = UserAccountViewModel()
    
    ///  用户模型
    var account: UserAccount?
    
    /// 用户登录标识
    var userLogon: Bool {
        
        //token 有值 并且没有过期
        return account?.access_token != nil && !isExpired
    }
    
    /// 归档保存的路径
    private var accountPath: String {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        
        return (path as NSString).stringByAppendingPathComponent("account.plist")
    
    }
    ///  判断账户是否过期
    private var isExpired: Bool {
        
        //过期时间和当前系统时间比较   降序 说明过期时间大  即没有过期
        if account?.expiresDate?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
            
            return false
        }
        
        //过期返回 true
        return true
    
    }
    
    ///  构造函数
    init() {
    
        // 从沙盒解档数据，恢复当前数据
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
        
        // 判断 token 是否过期
        if isExpired {
            print("已经过期")
            
            //如果过期,清空接档数据
            account = nil
        }
        
//        print(account)
    
    }
    
    ///  用户头像 URL
    var avatarURL: NSURL {
        return NSURL(string: account?.avatar_large ?? "")!
    }
    
}