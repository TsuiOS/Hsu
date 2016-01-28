//
//  AppDelegate.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupAppearance()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = XNWelcomeViewController()
        
        window?.makeKeyAndVisible()
        
        //测试网络工具
//        NetworkTools.sharedTools.request(.POST, URLString: "http:httpbin.org/post", parameters: ["name": "wangwu"]) { (result, error) -> () in
//            print(result)
//        }
        //测试归档的用户信息
//        print(UserAccountViewModel())
        // 测试检查新版本的代码
        print(isNewVersion)
        return true
    }
    
    ///  设置全局外观
    private func setupAppearance() {
    
    UINavigationBar.appearance().tintColor = XNAppearanceTintColor
    
    UITabBar.appearance().tintColor = XNAppearanceTintColor
    }

}

// MARK: - 界面切换代码
extension AppDelegate {
    
    ///  判断是否是新版本
    private var isNewVersion: Bool {
    
        //1. 当前版本
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let version = Double(currentVersion)!
        print("当前版本 \(version)")
        
        //2. 之前的版本
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(sandboxVersionKey)
        print("之前版本 \(sandboxVersion)")
        
        //3. 保存当前版本
        NSUserDefaults.standardUserDefaults().setDouble(version, forKey: sandboxVersionKey)
    
        return version > sandboxVersion
    }


}

