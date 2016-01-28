//
//  XNMainViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNMainViewController: UITabBarController {

    ///  监听方法
    @objc private func clickComposeButton() {
        print("点我了")
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
