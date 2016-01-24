//
//  XNMainViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
    }

}

// MARK: - 设置界面
extension XNMainViewController {

    /// 添加所有的控制器
    private func addChildViewControllers() {
        //设置tintColor 
        tabBar.tintColor = UIColor.orangeColor()
        addChildViewController(XNHomeTableViewController(), title: "首页", imageName: "tabbar_home")
        
        addChildViewController(XNMessageTableViewController(), title: "消息", imageName: "tabbar_message_center")

        addChildViewController(XNDiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")

        addChildViewController(XNProfileTableViewController(), title: "我", imageName: "tabbar_profile")

    }
    
    /// 添加控制器
    private func addChildViewController(vc: UIViewController, title : String, imageName: String ) {
        //设置标题
        vc.title = title
        
        //设置图像
        vc.tabBarItem.image = UIImage(named: imageName)
        
        // 导航控制器
        let nav = UINavigationController(rootViewController: vc)
        
        addChildViewController(nav)
    }

}
