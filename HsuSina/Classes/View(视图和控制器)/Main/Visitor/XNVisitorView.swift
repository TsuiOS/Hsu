//
//  XNVisitorView.swift
//  HsuSina
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SnapKit

/// 访客视图
class XNVisitorView: UIView {
    
    
    // MARK : - 设置视图信息
    ///  设置视图信息
    ///
    ///  - parameter imageName: 图片的名字,如果为nil 说明是首页
    ///  - parameter title:     消息文字
    func setupInfo(imageName: String?, title: String) {
    
         messageLable.text = title
        
        // 如果图片名为nil 说明是首页 直接返回
        guard let imgName = imageName else {
            startAnimation()
            return
        }
        iconView.image = UIImage(named: imgName)
        //隐藏小房子
        homeIconView.hidden = true
        //将遮罩移动到底层
        sendSubviewToBack(maskIconView)
    
    }
    
    ///  开始动画
    private func startAnimation() {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        //设置动画属性
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        
        //当控件销毁时, 动画才会一起销毁
        anim.removedOnCompletion = false
        
        iconView.layer.addAnimation(anim, forKey: nil)
    
    }
    
    // MARK : - 构造函数
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
    private lazy var iconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")
    
    ///遮罩图像
    private lazy var maskIconView: UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
    /// 房子
    private lazy var homeIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    /// 消息文字
    private lazy var messageLable: UILabel = UILabel(title: "关注一些人，回这里看看有什么惊喜")
    
    /// 注册按钮
    lazy var registerButton: UIButton = UIButton(title: "注册", color: UIColor.orangeColor(), backgroundImage: "common_button_white_disable")
    
    /// 登录按钮
    lazy var loginButton: UIButton = UIButton(title: "登录", color: UIColor.darkGrayColor(), backgroundImage: "common_button_white_disable")


}

extension XNVisitorView {
    /// 设置界面
    private func setupUI() {
    
        //1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLable)
        addSubview(registerButton)
        addSubview(loginButton)
    
        //2.设置自动布局
    
        //1. 图标
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY).offset(-60)
        }
        //2.房子
        homeIconView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(iconView.snp_center)
        }
        //3. 消息文字
        messageLable.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
            make.width.equalTo(224)
            make.height.equalTo(36)
        }
        //4. 注册按钮
        registerButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(messageLable.snp_left)
            make.top.equalTo(messageLable.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        //5. 登录按钮
        loginButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(messageLable.snp_right)
            make.top.equalTo(messageLable.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        //6 遮的自动布局

        maskIconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(registerButton.snp_top)
        }
        //设置背景颜色
        backgroundColor = UIColor(white: 237.0 / 255, alpha: 1.0)
        
        
    }


}
