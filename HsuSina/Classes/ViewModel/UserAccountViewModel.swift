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
    
    /// 归档保存的路径
    private var accountPath: String {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        
        return (path as NSString).stringByAppendingPathComponent("account.plist")
    
    }
    
    ///  构造函数
    init() {
    
        // 从沙盒解档数据，恢复当前数据
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
        
        print(account)
    
    }
    
    ///  用户头像 URL
    var avatarURL: NSURL {
        return NSURL(string: account?.avatar_large ?? "")!
    }
    
}