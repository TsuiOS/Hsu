//
//  XNWelcomeViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/27.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SnapKit

class XNWelcomeViewController: UIViewController {
    
    override func loadView() {
        // 直接使用背景图像作为根视图，不用关心图像的缩放问题
        view = backImageView
        
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    ///  设置欢迎界面的动画
    override func viewDidAppear(animated: Bool) {
        iconView.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-view.bounds.height + 200)
        }
        
        //设置动画
        welcomeLable.alpha = 0
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            
            }) { (_) -> Void in
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.welcomeLable.alpha = 1
                    }, completion: { (_) -> Void in
                        print("ok")
                })
        }
    }
    
    // MARK : - 懒加载控件
    /// 背景图像
    private lazy var backImageView: UIImageView = UIImageView(imageName: "ad_background")
    /// 头像
    private lazy var iconView: UIImageView = {
        
        let iv = UIImageView(imageName: "avatar_default_big")
        //设置圆角
        iv.layer.cornerRadius = 45
        iv.layer.masksToBounds = true
    
        return iv
    }()
    /// 欢迎标签
    private lazy var welcomeLable: UILabel = UILabel(title: "欢迎归来", fontSize: 18)
}

extension XNWelcomeViewController {

    private func setupUI() {
        //1.添加控件
        view.addSubview(iconView)
        view.addSubview(welcomeLable)
        
        //2.自动布局
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom)//.offset(-200)
            make.width.equalTo(90)
            make.width.equalTo(90)
        }
        
        welcomeLable.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
        }
    }

}