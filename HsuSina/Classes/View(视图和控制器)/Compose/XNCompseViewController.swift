//
//  XNCompseViewController.swift
//  HsuSina
//
//  Created by mac on 16/2/16.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SVProgressHUD

// MARK : - 撰写控制器
class XNCompseViewController: UIViewController {
    
    ///  照片选择控制器
    private lazy var picturePickerController = PicturePickerController()
    ///  表情键盘
    private lazy var emoticonView: EmoticonView = EmoticonView { [weak self](emoticon) -> () in
        self?.textView.insertEmoticon(emoticon)

    }
    
    
    // MARK: - 监听方法
    ///  关闭
    @objc private func close() {
        // 在退出控制器之前关闭键盘
        textView.resignFirstResponder()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    /// 发布微博
    @objc private func sendStatus() {
        
        // 1. 获取文本内容
        let text = textView.emoticonText
        let image = picturePickerController.pictures.last
        // 2. 发布微博
        NetworkTools.sharedTools.sendStatus(text, image: image) { (result, error) -> () in
            
            if error != nil {
                print("出错了 \(error?.localizedDescription)")
                SVProgressHUD.showInfoWithStatus("您的网络不给力")
                return
            }
            SVProgressHUD.showSuccessWithStatus("已发送")
            // 关闭控制器
            delay(0.5, callFunc: { () -> () in
                self.close()
            })
            
        }
    }
    
    /// 选择照片
    @objc private func selectPicture() {
        print("选择照片 \(picturePickerController.view.frame)")
        
        // 退掉键盘
        textView.resignFirstResponder()
        
        // 0. 判断如果已经更新了约束，不再执行后续代码
        if picturePickerController.view.frame.height > 0 {
            return
        }
        
        // 1. 修改照片选择控制器视图的约束
        picturePickerController.view.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(view.bounds.height * 0.6)
        }
        // 2. 修改文本视图的约束 - 重建约束 - 会将之前`textView`的所有的约束删除
        textView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottom.equalTo(picturePickerController.view.snp_top)
        }
        
        // 3. 动画更新约束
        UIView.animateWithDuration(0.5) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    ///  选择表情
    @objc private func selectEmoticon() {
        print("选择表情")
        // 1. 退掉系统键盘
        textView.resignFirstResponder()
        //2. 设置自定义键盘
        textView.inputView = textView.inputView == nil ? emoticonView : nil
        
        // 3. 重新激活键盘
        textView.becomeFirstResponder()
    }
    
    // MARK: - 键盘处理
    ///  键盘变化处理
    @objc private func keyboardChange(n: NSNotification) {
        print(n)
        
        // 1. 获取目标的 rect - 字典中的`结构体`是 NSValue
        let rect = (n.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        // 获取目标的动画时长 - 字典中的数值是 NSNumber
        let duration = (n.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        // 动画曲线数值
        let curve = (n.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue
        
        let offset = -UIScreen.mainScreen().bounds.height + rect.origin.y
        
        // 2. 更新约束
        toolbar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(offset)
        }
        
        // 3. 动画 － UIView 块动画 本质上是对 CAAnimation 的包装
        UIView.animateWithDuration(duration) { () -> Void in
            // 设置动画曲线
            /**
            曲线值 = 7
            － 如果之前的动画没有完成，有启动了其他的动画，让动画的图层直接运动到后续动画的目标位置
            － 一旦设置了 `7`，动画时长无效，动画时长统一变成 0.5s
            */
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)

            self.view.layoutIfNeeded()
        }
        
        // 调试动画时长 － keyPath 将动画添加到图层
        let anim = toolbar.layer.animationForKey("position")
        print("动画时长 \(anim?.duration)")
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加键盘通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardChange:",
            name: UIKeyboardWillChangeFrameNotification,
            object: nil)
    }
    deinit {
        // 注销通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
    // MARK : - 视图声明周期
    override func loadView() {
        view = UIView()
        
        setupUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 激活键盘 - 如果已经存在照片控制器视图，不再激活键盘
        if picturePickerController.view.frame.height == 0 {
            //激活键盘
            textView.becomeFirstResponder()
        }
    }
    
    // MARK: - 懒加载控件
    /// 工具条
    private lazy var toolbar = UIToolbar()
    
    /// 文本视图
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.orangeColor()
        tv.font = UIFont.systemFontOfSize(18)
        tv.textColor = UIColor.darkGrayColor()
        
        // 始终允许垂直滚动
        tv.alwaysBounceVertical = true
        // 拖拽关闭键盘
        tv.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        // 设置文本视图的代理
        tv.delegate = self
        
        return tv
    }()
    
    /// 占位标签
    private lazy var placeHolderLable: UILabel = UILabel(title: "分享新鲜事...",
        color: UIColor.lightGrayColor(),
        fontSize: 18)
}

// MARK: - UITextViewDelegate
extension XNCompseViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        placeHolderLable.hidden = textView.hasText()
    }

}

// MARK: - 设置界面
private extension XNCompseViewController {

    func setupUI() {
        // 0. 取消自动调整滚动视图间距
        automaticallyAdjustsScrollViewInsets = false
        // 设置背景颜色
        view.backgroundColor = UIColor.grayColor()
        
        // 设置控件
        prepareNavigationBar()
        prepareToolbar()
        prepareTextView()
        preparePicturePicker()
    }
    
    ///  准备照片选择控制器
    private func preparePicturePicker() {
        
        // 添加子控制器
        addChildViewController(picturePickerController)
        
        // 添加视图
        view.insertSubview(picturePickerController.view, belowSubview: toolbar)
        
        // 自动布局
        picturePickerController.view.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(0)
        }
    
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
        let itemSettings = [["imageName": "compose_toolbar_picture", "actionName": "selectPicture"],
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
        // 禁用发布微博按钮
        navigationItem.rightBarButtonItem?.enabled = false
        
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
