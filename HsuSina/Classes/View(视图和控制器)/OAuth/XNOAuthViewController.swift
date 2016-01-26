//
//  XNOAuthViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/26.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

/// 用户登录控制器
class XNOAuthViewController: UIViewController {
    
    /// 懒加载
    private lazy var webView = UIWebView()
    
    // MARK : - 监听方法
    @objc private func close() {
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK : - 设置界面
    override func loadView() {
        view = webView
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.whiteColor()
        // 加载页面
        self.webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthURL))
    }

    
}
