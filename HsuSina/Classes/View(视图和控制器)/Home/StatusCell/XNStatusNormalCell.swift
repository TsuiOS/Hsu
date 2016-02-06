//
//  XNStatusNormalCell.swift
//  HsuSina
//
//  Created by mac on 16/2/6.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNStatusNormalCell: XNStatusCell {

    /// 微博视图模型
    override var viewModel: StatusViewModel? {
        didSet {
            // 测试修改配图视图高度
            pictureView.snp_updateConstraints { (make) -> Void in
    
               // 根据配图的数量,决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count > 0 ? StatusCellMargin : 0
                make.top.equalTo(contentLable.snp_bottom).offset(offset)
            }
        
        }
    }
    override func setupUI() {
        super.setupUI()
        // 配图视图
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLable.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLable)
        }
    }
    
    
}
