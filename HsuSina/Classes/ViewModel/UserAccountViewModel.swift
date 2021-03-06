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
    
    /// 返回有效的 token
    var accessToken: String? {
    
        if !isExpired {
            return account?.access_token
        }
        return nil
    }
    
    /// 用户登录标识
    var userLogon: Bool {
        
        //token 有值 并且没有过期
        return account?.access_token != nil && !isExpired
    }
    ///  用户头像 URL
    var avatarURL: NSURL {
        return NSURL(string: account?.avatar_large ?? "")!
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
    }
    
}

// MARK: - 用户账户相关的网络方法
extension UserAccountViewModel {
    
    func loadAccessToken(code :String, finished:(isSuccessed: Bool) -> ()) {
        //4.加载 accessToken
        NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
            //判断错误
            if error != nil {
                print("授权失败")
                //失败的回调
                finished(isSuccessed: false)
                return
            }
            self.account = UserAccount(dict: result as! [String: AnyObject])
            self.loadUserInfo(self.account!,finished: finished)
            
        }
    }
    ///   加载用户信息
    ///
    ///  - parameter account: 用户账户对象
    private func loadUserInfo(account: UserAccount, finished:(isSuccessed: Bool) -> ()) {
        
        NetworkTools.sharedTools.loadUserInfo(account.uid!) { (result, error) -> () in
            if error != nil {
                print("加载用户出错了")
                finished(isSuccessed: false)
                return
            }
            guard let dict = result as? [String: AnyObject] else {
                print("格式错误")
                finished(isSuccessed: false)
                return
            }
            
            // dict 一定是一个有值的字典
            //保存用户信息
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            
            //保存对象
            NSKeyedArchiver.archiveRootObject(account, toFile: self.accountPath)
            
            print(self.accountPath)
            
            //成功的回调
            finished(isSuccessed: true)
            
        }
    }
    
}



