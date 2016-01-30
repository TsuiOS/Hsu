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
        
        print(defaultRootViewController)
        window?.rootViewController = defaultRootViewController
        print(window?.rootViewController)
        window?.makeKeyAndVisible()
        
        //测试网络工具
//        NetworkTools.sharedTools.request(.POST, URLString: "http:httpbin.org/post", parameters: ["name": "wangwu"]) { (result, error) -> () in
//            print(result)
//        }
        //测试归档的用户信息
//        print(UserAccountViewModel())
        // 测试检查新版本的代码
//        print(isNewVersion)
        ///  监听通知
        NSNotificationCenter.defaultCenter().addObserverForName(XNSwitchRootViewControllerNotification, // 通知名称
            object: nil,                             // 发送通知的对象, nil 监听任何对象
            queue: nil)                              // nil 主线程
            { [weak self](notification) -> Void in              // weak self
                
                //切换控制器
                let vc = notification.object != nil ? XNWelcomeViewController() : XNMainViewController()
                self?.window?.rootViewController = vc
        }
        
        return true
    }
    deinit {
        /// 注销通知
        NSNotificationCenter.defaultCenter().removeObserver(self, //监听通知者
            name: XNSwitchRootViewControllerNotification,         //监听的通知
            object: nil)                                          // 发送通知的对象
    
    }
    
    ///  设置全局外观
    private func setupAppearance() {
    
    UINavigationBar.appearance().tintColor = XNAppearanceTintColor
    
    UITabBar.appearance().tintColor = XNAppearanceTintColor
    }

}

// MARK: - 界面切换代码
extension AppDelegate {
    
    /// 启动的跟控制器
    private var defaultRootViewController: UIViewController {
    
        //1. 判断是否登录
        if UserAccountViewModel.sharedUserAccount.userLogon {
            return isNewVersion ? XNNewFeatureViewController() : XNWelcomeViewController()
        
        }
        //2. 没有登录返回主控制器
        return XNMainViewController()
    }
    
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

