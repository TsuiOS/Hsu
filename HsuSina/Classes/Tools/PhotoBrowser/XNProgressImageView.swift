//
//  XNProgressImageView.swift
//  HsuSina
//
//  Created by mac on 16/2/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

/// 带进度的图像视图
class XNProgressImageView: UIImageView {

    //一旦给构造函数指定了参数,系统就不会提供默认的构造函数
    init() {
        super.init(frame: CGRectZero)
        
        setupUI()
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(progressView)
        
        // 设置布局
        progressView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp_edges)
        }
    
    }
    
    // MARK : - 懒加载控件
    private lazy var progressView :XNProgressView = XNProgressView()

}

private class XNProgressView: UIView {
    
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath(ovalInRect: rect)
        
        UIColor.orangeColor().setFill()
        
        path.fill()
    }
}