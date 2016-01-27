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
        
        //设置代理
        webView.delegate = self
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

// MARK: - UIWebViewDelegate
extension XNOAuthViewController: UIWebViewDelegate {
    
    ///  将要加载请求的代理方法
    ///
    ///  - parameter webView:        webView
    ///  - parameter request:        将要加载的请求
    ///  - parameter navigationType: navigationType 页面跳转的方式
    ///
    ///  - returns: 返回 false 不加载 返回ture 继续加载
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //1.判断访问的主机是否是tsuios.applinzi.com
        guard let url = request.URL where url.host == "www.baidu.com" else {
        
            return true
        }
        //2.从上面的 url 中提取 code = 是否存在
        guard let query = url.query where query.hasPrefix("code=") else {
        
            print("取消授权")
            return false
        }
        
        //3.从 query 中提取 code= 后面的授权码
        let code = query.substringFromIndex("code=".endIndex)
        print(query)
        //b7df9c2654d71987d8f9f6745b43642e
        print("授权码是 " + code)
        
        //4.加载 accessToken
        NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
            //判断错误
            if error != nil {
                print("授权失败")
                return
            }
            let account = UserAccount(dict: result as! [String: AnyObject])
            self.loadUserInfo(account)
            
        }

        return false
        
    }
    ///  加载用户信息
    private func loadUserInfo(account: UserAccount) {
        
        NetworkTools.sharedTools.loadUserInfo(account.uid!, accessToken: account.access_token!) { (result, error) -> () in
            if error != nil {
                print("加载用户出错了")
                
                return
            }
            guard let dict = result as? [String: AnyObject] else {
                print("格式错误")
                
                return
            }
            
            // dict 一定是一个有值的字典
            //保存用户信息
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            print(account)
        }
    
    
    }

}
