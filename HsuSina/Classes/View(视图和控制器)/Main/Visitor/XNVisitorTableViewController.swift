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
        
        //设置代理
        visitorView?.delegate = self
        view = visitorView
        
    }
    
}

// MARK: - 访客视图监听方法
extension XNVisitorTableViewController: XNVisitorViewDelegate {

    func visitorViewDidRegister() {
        print("注册")
    }
    
    func visitorViewDidLogin() {
        print("登录")
    }
}