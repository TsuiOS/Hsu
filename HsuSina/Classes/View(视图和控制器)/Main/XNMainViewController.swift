//
//  XNMainViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNMainViewController: UITabBarController {

    // MARK : - 监听方法
    /// 点击撰写按钮
    /// 如果`单纯`使用 `private` 运行循环将无法正确发送消息，导致崩溃
    /// 如果使用 @objc 修饰符号，可以保证运行循环能够发送此消息，即使函数被标记为 private
    @objc private func clickComposeButton() {
        
        // 判断用户是否登录
        var vc: UIViewController
        if UserAccountViewModel.sharedUserAccount.userLogon {
            vc = XNCompseViewController()
        } else {
            vc = XNOAuthViewController()
        }
        
        let nav = UINavigationController(rootViewController: vc)
        
        presentViewController(nav, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
    }
    
    override func viewWillAppear(animated: Bool) {
        //会创建 tabbar 中的所有控制器对应的按钮
        super.viewWillAppear(animated)
        setupComposeButton()
    }
    
    // MARK : 懒加载
    private lazy var composedButton: UIButton = UIButton(
        imageName: "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button"
    )
}

// MARK: - 设置界面
extension XNMainViewController {
    
    /// 设置撰写按钮
    private func setupComposeButton() {
    
        //1.添加按钮
        tabBar.addSubview(composedButton)
        // 调整按钮
        let count = childViewControllers.count
        let w = tabBar.bounds.width / CGFloat(count) - 1
        composedButton.frame = CGRectInset(tabBar.bounds, 2 * w, 0)
        
        composedButton.addTarget(self, action: "clickComposeButton", forControlEvents: .TouchUpInside)
 
    }

    /// 添加所有的控制器
    private func addChildViewControllers() {
       
        addChildViewController(XNHomeTableViewController(), title: "首页", imageName: "tabbar_home")
        
        addChildViewController(XNMessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        
        addChildViewController(UIViewController())
        
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
