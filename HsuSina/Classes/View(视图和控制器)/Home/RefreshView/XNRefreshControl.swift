//
//  XNRefreshControl.swift
//  HsuSina
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SnapKit
/// 自定义刷新控件 - 负责处理刷新逻辑
class XNRefreshControl: UIRefreshControl {
    
    /// 构造函数
    override init() {
        super.init()
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(refreshView)
        
//        //自动布局 - 从 xib 加载的控件需要指定大小约束
//        refreshView.snp_makeConstraints { (make) -> Void in
//            make.centerX.equalTo(self.snp_centerX)
//            make.centerY.equalTo(self.snp_centerY)
//            make.size.equalTo(refreshView.bounds.size)
//        }
//        
    }
    
    // MARK: - 懒加载控件
    private lazy var refreshView = XNRefreshView.refreshView()
}

/// 刷新视图 - 负责吃力动画显示
class XNRefreshView: UIView {
    
    // 从 xib 加载视图
    class func refreshView() -> XNRefreshView {
        
        let nib = UINib(nibName: "XNRefreshView", bundle: nil)
        return nib.instantiateWithOwner(nil, options: nil)[0] as! XNRefreshView
    }
}
