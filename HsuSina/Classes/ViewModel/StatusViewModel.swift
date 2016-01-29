//
//  StatusViewModel.swift
//  HsuSina
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 Hsu. All rights reserved.
//
import UIKit

/// 单条微博视图模型
class StatusViewModel {
    
    ///  微博模型
    var status: XNStatus
    
    /// 用户头像 url
    var userProfileURL: NSURL {
        return NSURL(string: status.user?.profile_image_url ?? "")!
    }
    //用户默认头像
    var userDefaultIconView: UIImage {
        return UIImage(named: "avatar_default_big")!
    
    }
    /// 用户会员图标
    var userMemberImage: UIImage? {
        
        //根据 mbrank来生成图像
        if status.user?.mbrank > 0 && status.user?.mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    /// 用户认证图标
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var userVipImage: UIImage? {
        
        switch(status.user?.verified_type ?? -1) {
        case 0: return UIImage(named: "avatar_vip")
        case 2, 3, 5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        
        default: return nil
        }
    }
    ///  构造函数
    init(status: XNStatus) {
        self.status = status
    
    }
    
}