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
    ///  选择表情
    @objc private func selectEmoticon() {
        print("选择表情")
    }
    
    // MARK : - 视图声明周期
    override func loadView() {
        view = UIView()
        
        setupUI()
    }
    
    // MARK: - 懒加载控件
    
    /// 工具条
    private lazy var toolbar = UIToolbar()
    
    /// 文本视图
    private lazy var textView: UITextView = {
        let tv = UITextView()
        
        tv.font = UIFont.systemFontOfSize(18)
        tv.textColor = UIColor.darkGrayColor()
        
        // 始终允许垂直滚动
        tv.alwaysBounceVertical = true
        // 拖拽关闭键盘
        tv.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        return tv
    }()
    
    /// 占位标签
    private lazy var placeHolderLable: UILabel = UILabel(title: "分享新鲜事...",
        color: UIColor.lightGrayColor(),
        fontSize: 18)
}

// MARK: - 设置界面
private extension XNCompseViewController {

    func setupUI() {
        // 设置背景颜色
        view.backgroundColor = UIColor.grayColor()
        
        // 设置控件
        prepareNavigationBar()
        prepareToolbar()
        prepareTextView()
        
    }
    
    ///  准备文本视图
    private func prepareTextView() {
         view.addSubview(textView)
        
        textView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(toolbar.snp_top)
        }
        
//        textView.text = "分享新鲜事..."
        
        // 添加占位标签
        textView.addSubview(placeHolderLable)
        
        placeHolderLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(textView.snp_top).offset(8)
            make.left.equalTo(textView.snp_left).offset(5)
        }
    
    }
    
    ///  准备工具条
    private func prepareToolbar() {
        
        //1. 添加控件
        view.addSubview(toolbar)
        
        toolbar.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        //2. 自动布局
        toolbar.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(44)
        }
        //3. 添加按钮
        let itemSettings = [["imageName": "compose_toolbar_picture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"],
            ["imageName": "compose_addbutton_background"]]
        
        var items = [UIBarButtonItem]()
        
        for dict in itemSettings {
            
            let item = UIBarButtonItem(imageName: dict["imageName"]!,
                target: self,
                actionName: dict["actionName"])
            
            items.append(item)
            
            // 添加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        
        toolbar.items = items
    
    }
    
    ///  设置导航栏
    private func prepareNavigationBar() {
        
        // 1. 左右边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "close")
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: "sendStatus")
        
        //2. 设置标题 方式一
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

        
//        // 2.标题视图 方式二
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
//        navigationItem.titleView = titleView
//        // 3.添加子控件
//        let titleLabel = UILabel(title: "发微博\n", fontSize: 13)
//        // 使用富文本
//        let attr = NSMutableAttributedString()
//        
//        let sendAttr = NSAttributedString(string: "发微博\n",
//            attributes: [NSFontAttributeName:UIFont.systemFontOfSize(13)])
//        
//        attr.appendAttributedString(sendAttr)
//        
//        let nameAttr = NSAttributedString(string: UserAccountViewModel.sharedUserAccount.account?.screen_name ?? "",
//            attributes: [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.redColor()])
//        
//        attr.appendAttributedString(nameAttr)
//        
//        titleLabel.attributedText = attr
//        
//        titleView.addSubview(titleLabel)
//        
//        // 自动布局
//        titleLabel.snp_makeConstraints { (make) -> Void in
//            make.centerX.equalTo(titleView.snp_centerX)
//            make.top.equalTo(titleView.snp_top)
//        }
    
    }
}
