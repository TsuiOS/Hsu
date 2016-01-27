//
//  AppDelegate.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
//测试 master
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
        
        
        return true
    }
    
    ///  设置全局外观
    private func setupAppearance() {
    
    UINavigationBar.appearance().tintColor = XNAppearanceTintColor
    
    UITabBar.appearance().tintColor = XNAppearanceTintColor
    }

}

