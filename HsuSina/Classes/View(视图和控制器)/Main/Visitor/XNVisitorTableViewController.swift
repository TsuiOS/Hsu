//
//  XNVisitorTableViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNVisitorTableViewController: UITableViewController {

    //用户登录标记
    private var userLogin = false
    
    var visitorView: XNVisitorView?
    
    override func viewDidLoad() {
        
        //根据用户登录情况,决定显示的视图
        userLogin ? super.viewDidLoad() : setupVisitorView()
        
    }
    ///  设置访客视图
    private func setupVisitorView() {
    
        //替换视图
        visitorView = XNVisitorView()
        view = visitorView
        
        //添加监听方法
        visitorView?.registerButton.addTarget(self, action: "visitorViewDidRegister", forControlEvents: .TouchUpInside)
        visitorView?.loginButton.addTarget(self, action: "visitorViewDidLogin", forControlEvents: .TouchUpInside)
        
        //设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "visitorViewDidRegister")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "visitorViewDidLogin")
        
    }
    
}

// MARK: - 访客视图监听方法
extension XNVisitorTableViewController {

    ///  注册
    func visitorViewDidRegister() {
        print("注册")
    }
    ///  登录
    func visitorViewDidLogin() {
        print("登录")
    }
}