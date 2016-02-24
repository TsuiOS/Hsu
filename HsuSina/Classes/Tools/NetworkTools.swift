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
    /// - parameter image:    微博配图
    /// - parameter finished: 完成回调
    /// - see: [http://open.weibo.com/wiki/2/statuses/update](http://open.weibo.com/wiki/2/statuses/update)
    func sendStatus(status: String, image: UIImage?, finished: XNRequesCallBack) {
        
        // 1. 创建参数字典
        var params = [String: AnyObject]()

        // 2. 设置参数
        params["status"] = status
        
        // 3.判断是否上传图片
        if image == nil {
            let urlString = "https://api.weibo.com/2/statuses/update.json"
            
            //发起网络请求
            tokenRequest(.POST, URLString: urlString, parameters: params, finished: finished)
        } else {
            let urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
            
            let data = UIImagePNGRepresentation(image!)
            
            upload(urlString, data: data!, name: "pic", parameters: params, finished: finished)
        }
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
    
    /// 向 parameters 字典中追加 token 参数
    ///
    /// - parameter parameters: 参数字典
    ///
    /// - returns: 是否追加成功
    /// - 默认情况下，关于函数参数，在调用时，会做一次 copy，函数内部修改参数值，不会影响到外部的数值
    /// - inout 关键字，相当于在 OC 中传递对象的地址
    private func appendToken(inout parameters: [String: AnyObject]?) -> Bool {
        
        // 1> 判断 token 是否为nil
        guard let token = UserAccountViewModel.sharedUserAccount.accessToken else {
            return false
        }
        
        // 2> 判断参数字典是否有值
        if parameters == nil {
            parameters = [String: AnyObject]()
        }
        
        // 3> 设置 token
        parameters!["access_token"] = token
        
        return true
    }
    
    /// 使用 token 进行网络请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter finished:   完成回调
    private func tokenRequest(method: XNRequestMethod, URLString: String, var parameters: [String: AnyObject]?, finished: XNRequesCallBack) {
        
        //1. 设置 token 参数
        //判断 token 是否有效
        if !appendToken(&parameters){
            
            finished(result: nil, error: NSError(domain: "com.tsuios.error", code: 1024, userInfo: ["message": "token为空"]) )
            return
        }
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
    private func upload(URLString: String, data: NSData, name: String, var parameters: [String: AnyObject]?, finished: XNRequesCallBack) {
        
        
        //1. 设置 token 参数
        //判断 token 是否有效
        if !appendToken(&parameters) {
            
            finished(result: nil, error: NSError(domain: "com.tsuios.error", code: 1024, userInfo: ["message": "token为空"]) )
            return
        }
    
        POST(URLString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
            
            ///  @param data        要上传文件的二进制数据
            ///  @param name        是服务器定义的字段名称
            ///  @param fileName    保存在服务器的文件名 后台会处理,名字随便写
            ///  @param mimeType /contentType 二进制数据的准确类型
             formData.appendPartWithFileData(data, name: name, fileName: "xxx", mimeType: "application/octet-stream")
            }, progress: nil, success: { (_, result) -> Void in
                finished(result: result, error: nil)
            }) { (_, error) -> Void in
                finished(result: nil, error: error)
        }
    }
}