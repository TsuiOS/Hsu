//
//  XNXNStatusCellTopView.swift
//  HsuSina
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
/// 微博 Cell 中控件的间距数值
let StatusCellMargin: CGFloat = 12
/// 微博头像的宽度
let StatusCellIconWidth: CGFloat = 35

/// 顶部视图
class XNStatusCellTopView: UIView {
    
    /// 微博视图模型
    var viewModel: StatusViewModel? {
        didSet {
            // 姓名
            nameLable.text = viewModel?.status.user?.screen_name
            // 头像
            iconView.sd_setImageWithURL(viewModel?.userProfileURL, placeholderImage: viewModel?.userDefaultIconView)
            // 会员图标
            memberIconView.image = viewModel?.userMemberImage
            // 认证图标
            vipIconView.image = viewModel?.userVipImage
            //时间标签
            timeLabel.text = "公元前120年"
            //来源
            sourceLabel.text = "来自 HsuVV"
        }
    }
    
    // MARK : - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK : - 懒加载控件
    /// 头像 iconView
    private lazy var iconView: UIImageView = UIImageView(imageName: "avatar_default_big")
    /// 姓名 nameLabel
    private lazy var nameLable: UILabel = UILabel(title: "姓名", color: UIColor.darkGrayColor(), fontSize: 14)
    /// 会员图标 memberIconView
    private lazy var memberIconView: UIImageView = UIImageView(imageName: "common_icon_membership_level1")
    /// 认证图标 vipIconView
    private lazy var vipIconView: UIImageView = UIImageView(imageName: "avatar_enterprise_vip")
    /// 时间标签 timeLabel
    private lazy var timeLabel: UILabel = UILabel(title: "公元前120年", color: UIColor.darkGrayColor(), fontSize: 11)
    /// 来源标签 sourceLabel
    private lazy var sourceLabel: UILabel = UILabel(title: "来源: HsuVV", color: UIColor.darkGrayColor(), fontSize: 11)
}

// MARK: - 设置界面
extension XNStatusCellTopView {

    private func setupUI() {
        
        /// 设置分割线
        let sepView = UIView()
        sepView.backgroundColor = UIColor(red: 214 / 255.0, green: 214 / 255.0, blue: 214 / 255.0, alpha: 1.0)
        addSubview(sepView)
        
        // 设置背景色
//        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        //1. 添加控件
        addSubview(iconView)
        addSubview(nameLable)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        //2. 自动布局
        sepView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(StatusCellMargin)
        }
        // 头像
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(sepView.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(self).offset(StatusCellMargin)
            make.width.equalTo(StatusCellIconWidth)
            make.height.equalTo(StatusCellIconWidth)
        }
        // 姓名
        nameLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp_right).offset(StatusCellMargin)
        }
        // 会员图标
        memberIconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLable)
            make.left.equalTo(nameLable.snp_right).offset(StatusCellMargin)
        }
        //认证图标
        vipIconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_right)
            make.centerY.equalTo(iconView.snp_bottom)
        }
        //时间标签
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLable)
            make.bottom.equalTo(iconView)
        }
        //来源标签
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(timeLabel.snp_right).offset(StatusCellMargin)
            make.bottom.equalTo(timeLabel)
        }
    }
}
