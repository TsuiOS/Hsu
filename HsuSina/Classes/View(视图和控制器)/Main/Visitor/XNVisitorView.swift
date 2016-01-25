//
//  XNVisitorView.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

/// 访客视图
class XNVisitorView: UIView {
    
    //initWithFrame 是 UIView 的指定构造函数
    //使用纯代码开发使用
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    //initWithCoder 使用 sb 或者 xib 开发加载的函数
    required init?(coder aDecoder: NSCoder) {
        //纯代码开发是,调用fatalError方法程序会崩溃
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }
    // MARK : - 懒加载控件
    ///  图标
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    /// 房子
    private lazy var homeIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    /// 消息文字
    private lazy var messageLable: UILabel = {
        let lable = UILabel()
        lable.text = "关注一些人，回这里看看有什么惊喜"
        // 界面设计上,避免使用纯黑色
        lable.textColor = UIColor.darkGrayColor()
        lable.font = UIFont.systemFontOfSize(14)
        lable.numberOfLines = 0

        return lable
    }()
    
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("注册", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        return button
    }()
    /// 登录按钮
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("登录", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        return button
    }()

}

extension XNVisitorView {
    ///  设置界面
    private func setupUI() {
    
        //1.添加控件
        addSubview(iconView)
        addSubview(homeIconView)
        addSubview(messageLable)
        addSubview(registerButton)
        addSubview(loginButton)
    
        //2.设置自动布局
        /**
        - 添加约束需要添加到父视图上
        - 建议，子视图最好有一个统一的参照物！
        */
        // translatesAutoresizingMaskIntoConstraints 默认是 true，支持使用 setFrame 的方式设置控件位置
        // false 支持使用自动布局来设置控件位置
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
    
        //1. 图标
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0))
        //2.房子
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .CenterX, relatedBy: .Equal, toItem: iconView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .CenterY, relatedBy: .Equal, toItem: iconView, attribute: .CenterY, multiplier: 1.0, constant: 0))
        //3. 消息文字
        addConstraint(NSLayoutConstraint(item: messageLable, attribute: .CenterX, relatedBy: .Equal, toItem: iconView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLable, attribute: .Top, relatedBy: .Equal, toItem: iconView, attribute: .Bottom, multiplier: 1.0, constant: 16))
        //设置lable 的宽高
        addConstraint(NSLayoutConstraint(item: messageLable, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 224))
        addConstraint(NSLayoutConstraint(item: messageLable, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 16))
        //4. 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Left, relatedBy: .Equal, toItem: messageLable, attribute: .Left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Top, relatedBy: .Equal, toItem: messageLable, attribute: .Bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 36))
        //5. 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Right, relatedBy: .Equal, toItem: messageLable, attribute: .Right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Top, relatedBy: .Equal, toItem: messageLable, attribute: .Bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 36))
        
        
    }


}
