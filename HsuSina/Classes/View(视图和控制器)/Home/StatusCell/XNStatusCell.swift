//
//  XNStatusCell.swift
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

/// 微博 cell
class XNStatusCell: UITableViewCell {
    
    ///  微博视图模型
    var viewModel: StatusViewModel? {
        didSet {
            topView.viewModel = viewModel
            contentLable.text = viewModel?.status.text
        }
    }
    // MARK : - 构造函数
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 懒加载控件
    
    /// 顶部视图
    private lazy var topView: XNStatusCellTopView = XNStatusCellTopView()
    /// 微博正文
    private lazy var contentLable: UILabel = UILabel(title: "微博正文",
                                                     color:  UIColor.darkGrayColor(),
                                                  fontSize: 15,
                                               screenInset: StatusCellMargin)
    
    /// 底部视图
    private lazy var bottomView: XNStatusCellBottomView = XNStatusCellBottomView()
    
}

// MARK: - 设置界面
extension XNStatusCell {

    private func setupUI() {
        //1. 添加控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLable)
        contentView.addSubview(bottomView)
        
        backgroundColor = UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1.0)
    
        //2. 自动布局
        ///  顶部视图
        topView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(2 * StatusCellMargin + StatusCellIconWidth)
        }
        ///  内容标签
        contentLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp_left).offset(StatusCellMargin)

        }
        // 底部视图
        // 3> 底部视图
        bottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLable.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(44)
            
            // 指定向下的约束
            make.bottom.equalTo(contentView.snp_bottom)
        }
    
    }

}
