//
//  XNCompseViewController.swift
//  HsuSina
//
//  Created by mac on 16/2/16.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNCompseViewController: UIViewController {
    
    // MARK : - 监听方法
    ///  关闭
    @objc private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    ///发布微博
    @objc private func sendStatus() {
    
        print("发布微博")
    }
    
    // MARK : - 视图声明周期
    override func loadView() {
        view = UIView()
        
        setupUI()
    }
}

// MARK: - 设置界面
private extension XNCompseViewController {

    func setupUI() {
        // 设置背景颜色
        view.backgroundColor = UIColor.grayColor()
        
        // 设置控件
        prepareNavigationBar()
    }
    
    ///  设置导航栏
    private func prepareNavigationBar() {
        
        // 1. 左右边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "close")
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: "sendStatus")
        
        //2. 设置标题
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        navigationItem.titleView = titleView
        
        //3. 添加子控件
        let titleLable = UILabel(title: "发微博", fontSize: 15)
        let nameLable = UILabel(title: UserAccountViewModel.sharedUserAccount.account?.screen_name ?? "",
            color: UIColor.grayColor(),
            fontSize: 13)
        
        titleView.addSubview(titleLable)
        titleView.addSubview(nameLable)
        
        // 自动布局
        titleLable.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleView.snp_centerX)
            make.top.equalTo(titleView.snp_top)
        }
        nameLable.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleView.snp_centerX)
            make.bottom.equalTo(titleView.snp_bottom)
        }

    
    }
}
