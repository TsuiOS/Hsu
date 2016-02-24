//
//  NetworkTools.swift
//  测试-05-AFN Swift
//
//  Created by male on 15/10/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import AFNetworking

/// HTTP 请求方法枚举
enum XNRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

// MARK: 网络工具
class NetworkTools: AFHTTPSessionManager {
    
    // MARK: - 应用程序信息
    private let appKey = "2344169185"
    private let appSecret = "11a8007451fb9ce6a12b5da7d98bee99"
    private let redirectUrl = "http://www.baidu.com"
    
    typealias XNRequesCallBack = (result: AnyObject?, error: NSError?)->()

    // 单例
    static let sharedTools: NetworkTools = {
        
        let tools = NetworkTools(baseURL: nil)
        
        // 设置反序列化数据格式 - 系统会自动将 OC 框架中的 NSSet 转换成 Set
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
    /// 返回 token 字典
//    private var tokenDict: [String: AnyObject]? {
//        //判断 token 是否有效
//        if let token = UserAccountViewModel.sharedUserAccount.accessToken {
//        
//            return ["access_token": token]
//        }
//        return nil
//    }
}

// MARK: - 发布微博
extension NetworkTools {
    
    /// 发布微博
    ///
    /// - parameter status:   微博文本
    /// - parameter finished: 完成回调
    /// - see: [http://open.weibo.com/wiki/2/statuses/update](http://open.weibo.com/wiki/2/statuses/update)
    func sendStatus(status: String, finished: XNRequesCallBack) {
        
        // 1. 创建参数字典
        var params = [String: AnyObject]()

        // 2. 设置参数
        params["status"] = status
        
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        // 3. 发起网络请求
        tokenRequest(.POST, URLString: urlString, parameters: params, finished: finished)
    }
}

// MARK: - 微博数据相关的方法
extension NetworkTools {
    
    ///  加载微博书记
    ///
    ///  - parameter finished: 完成回调
    /// - see [https://api.weibo.com/2/statuses/home_timeline.json](https://api.weibo.com/2/statuses/home_timeline.json)
    func loadStatus(finished: XNRequesCallBack) {
        
        // 1. 创建参数字典
        let params = [String: AnyObject]()
        
        //2. 准备网络参数
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        //3. 发起网络请求
        tokenRequest(.GET, URLString: urlString, parameters: params, finished: finished)
        
    }

}


// MARK: - 用户相关的方法
extension NetworkTools {

    ///  加载用户信息
    ///
    ///  - parameter uid:         需要查询的用户ID
    ///  - parameter finished:    完成后的回调
    ///- see [http://open.weibo.com/wiki/2/users/show](http://open.weibo.com/wiki/2/users/show)
    /// 参数uid与screen_name二者必选其一，且只能选其一
    func loadUserInfo(uid: String, finished: XNRequesCallBack) {
        
        // 1. 创建参数字典
        var params = [String: AnyObject]()
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        params["uid"] = uid
        
        tokenRequest(.GET, URLString: urlString, parameters: params, finished: finished)
    
    }

}

// MARK: - OAuth相关方法
extension NetworkTools {
    
    /// OAuth 授权 URL
    /// - see [http://open.weibo.com/wiki/Oauth2/authorize](http://open.weibo.com/wiki/Oauth2/authorize)
    var oauthURL: NSURL {
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        return NSURL(string: urlString)!
        
    }
    ///  加载 AccessToken
    ///
    ///  - parameter code:     授权码
    ///  - parameter finished: 完成的回调
    /// - see [http://open.weibo.com/wiki/OAuth2/access_token](http://open.weibo.com/wiki/OAuth2/access_token)\
    func loadAccessToken(code: String, finished: XNRequesCallBack)
    {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id": appKey,
                  "client_secret": appSecret,
                     "grant_type": "authorization_code",
                           "code": code,
                   "redirect_uri": redirectUrl]
        
        request(.POST, URLString: urlString, parameters: params, finished: finished)
    }
    
}

// MARK: - 封装 AFN 网络方法
extension NetworkTools {
    
    /// 使用 token 进行网络请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter finished:   完成回调
    private func tokenRequest(method: XNRequestMethod, URLString: String, var parameters: [String: AnyObject]?, finished: XNRequesCallBack) {
        
        //1. 设置 token 参数
        //判断 token 是否有效
        guard let token = UserAccountViewModel.sharedUserAccount.accessToken else {
            
            finished(result: nil, error: NSError(domain: "com.tsuios.error", code: 1024, userInfo: ["message": "token为空"]) )
            return
        }
        //设置parameters字典
        // 判断参数字典是否有值
        if parameters == nil {
            parameters = [String: AnyObject]()
        }
        parameters!["access_token"] = token
        //2. 发起网络请求
        request(method, URLString: URLString, parameters: parameters, finished: finished)
    
    }
    
    /// 网络请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter finished:   完成回调
    func request(method: XNRequestMethod, URLString: String, parameters: [String: AnyObject]?, finished: XNRequesCallBack) {
        
        // 定义成功回调
        let success = { (task: NSURLSessionDataTask?, result: AnyObject?) -> Void in
            finished(result: result, error: nil)
        }
        // 定义失败回调
        let failure = { (task: NSURLSessionDataTask?, error: NSError?) -> Void in
            // 在开发网络应用的时候，错误不要提示给用户，但是错误一定要输出！
            print(error?.localizedDescription)
            finished(result: nil, error: error)
        }
        
        if method == XNRequestMethod.GET {
            GET(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            POST(URLString, parameters: parameters, progress: nil, success: success, failure: failure)

        }
    }
    ///  上传图片
    ///
    ///  - parameter URLString:  <#URLString description#>
    ///  - parameter parameters: <#parameters description#>
    ///  - parameter finished:   <#finished description#>
    private func upload(URLString: String, parameters: [String: AnyObject]?, finished: XNRequesCallBack) {
        POST(<#T##URLString: String##String#>, parameters: <#T##AnyObject?#>, constructingBodyWithBlock: <#T##((AFMultipartFormData) -> Void)?##((AFMultipartFormData) -> Void)?##(AFMultipartFormData) -> Void#>, progress: <#T##((NSProgress) -> Void)?##((NSProgress) -> Void)?##(NSProgress) -> Void#>, success: <#T##((NSURLSessionDataTask, AnyObject?) -> Void)?##((NSURLSessionDataTask, AnyObject?) -> Void)?##(NSURLSessionDataTask, AnyObject?) -> Void#>, failure: <#T##((NSURLSessionDataTask?, NSError) -> Void)?##((NSURLSessionDataTask?, NSError) -> Void)?##(NSURLSessionDataTask?, NSError) -> Void#>)
    }
}
