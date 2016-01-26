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
    ///  自动填充用户名和密码
    @objc private func autoFill() {
        
        let js = "document.getElementById('userId').value = '957430432@qq.com';" +
        "document.getElementById('passwd').value = '13280459899';"
        // 让 webView 执行 js
        webView.stringByEvaluatingJavaScriptFromString(js)
    }
    
    // MARK : - 设置界面
    override func loadView() {
        view = webView
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动登录", style: .Plain, target: self, action: "autoFill")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.whiteColor()
        // 加载页面
        self.webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthURL))
    }

    
}
