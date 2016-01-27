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
    
    ///  用户头像 URL
    var avatarURL: NSURL {
        return NSURL(string: account?.avatar_large ?? "")!
    }
    
}