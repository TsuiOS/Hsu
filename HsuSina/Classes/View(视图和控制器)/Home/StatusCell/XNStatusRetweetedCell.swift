//
//  XNStatusRetweetedCell.swift
//  HsuSina
//
//  Created by mac on 16/2/6.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

/// 转发微博 cell
class XNStatusRetweetedCell: XNStatusCell {
    
    /// 微博视图模型
   override var viewModel: StatusViewModel? {
        didSet {
            // 转发微博的文字
            retweetedLabel.text = viewModel?.retweetedText
            print(viewModel?.retweetedText)

            pictureView.snp_updateConstraints { (make) -> Void in
                // 根据配图的数量,决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count > 0 ? StatusCellMargin : 0
                make.top.equalTo(retweetedLabel.snp_bottom).offset(offset)
                
            }
        }
    }
    // MARK : - 懒加载控件
    /// 背景按钮
    private lazy var backButton: UIButton = {
    
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        return button
    }()
    ///  转发标签
    private lazy var retweetedLabel: UILabel = UILabel(
        title: "转发微博",
        color: UIColor.darkGrayColor(),
        fontSize: 14,
        screenInset: StatusCellMargin)

}

// MARK: - 设置界面
extension XNStatusRetweetedCell {
    
    override func setupUI() {
        super.setupUI()
        
        //1. 添加控件
        contentView.insertSubview(backButton, belowSubview: pictureView)
        contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
        
        //2. 自动布局
        //1> 背景按钮
        backButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLable.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(bottomView.snp_top)
        }
        //2> 转发标签
        retweetedLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(backButton).offset(StatusCellMargin)
            make.left.equalTo(backButton).offset(StatusCellMargin)
        }
        //3> 配图视图
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedLabel.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(retweetedLabel)
        }
        
        
        
    }

}
