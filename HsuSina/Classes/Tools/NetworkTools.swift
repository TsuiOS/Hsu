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

    // 单例
    static let sharedTools: NetworkTools = {
        
        let tools = NetworkTools(baseURL: nil)
        
        // 设置反序列化数据格式 - 系统会自动将 OC 框架中的 NSSet 转换成 Set
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
    }()
}

// MARK: - 封装 AFN 网络方法
extension NetworkTools {
    
    /// 网络请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter finished:   完成回调
    func request(method: XNRequestMethod, URLString: String, parameters: [String: AnyObject]?, finished: (result: AnyObject?, error: NSError?)->()) {
        
        // 定义成功回调
        let success = { (task: NSURLSessionDataTask?, result: AnyObject?) -> Void in
            finished(result: result, error: nil)
        }
        
        // 定义失败回调
        let failure = { (task: NSURLSessionDataTask?, error: NSError?) -> Void in
            // 在开发网络应用的时候，错误不要提示给用户，但是错误一定要输出！
            print(error)
            finished(result: nil, error: error)
        }
        
        if method == XNRequestMethod.GET {
            GET(URLString, parameters: parameters, success: success, failure: failure)
        } else {
            POST(URLString, parameters: parameters, success: success, failure: failure)
        }
        
    }
}
