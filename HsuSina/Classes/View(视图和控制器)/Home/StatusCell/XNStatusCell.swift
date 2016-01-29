//
//  XNStatusCell.swift
//  HsuSina
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
/// 微博 cell
class XNStatusCell: UITableViewCell {
    
    ///  微博视图模型
    var viewModel: StatusViewModel? {
        didSet {
            topView.viewModel = viewModel
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
    private lazy var contentLable: UILabel = UILabel(title: "微博正文", fontSize: 15)
    /// 底部视图
    private lazy var bottomView: XNStatusCellBottomView = XNStatusCellBottomView()
    
}

// MARK: - 设置界面
extension XNStatusCell {

    private func setupUI() {
        //1. 添加控件
        contentView.addSubview(topView)
        backgroundColor = UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1.0)
        
        //2. 自动布局
        topView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(60)
        }
    
    }

}
