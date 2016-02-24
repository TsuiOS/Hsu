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
    
    ///  外部传递的进度值
    var progress: CGFloat = 0 {
        didSet {
            progressView.progress = progress
            
        }
    }
    // MARK : - 构造函数
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
        progressView.backgroundColor = UIColor.clearColor()
        
        // 设置布局
        progressView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp_edges)
        }
    
    }
    
    // MARK : - 懒加载控件
    private lazy var progressView :XNProgressView = XNProgressView()

}

private class XNProgressView: UIView {
    ///  内部使用的进度值
    var progress: CGFloat = 0 {
        didSet {
            // 重绘视图
            setNeedsDisplay()
        }
    }
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        // 进度圆半径
        let radius = min(rect.width, rect.height) * 0.4
        //空心圆半径
        let r = min(rect.width, rect.height) * 0.45
        let start = CGFloat(-M_PI_2)
        // 进度圆的截止弧度
        let end = start + progress * 2 * CGFloat(M_PI_2)
        // 空心圆
        let endS = 3 * CGFloat(M_PI_2)
        
        // 空心圆
        let pathStroke = UIBezierPath(arcCenter: center, radius: r, startAngle: start, endAngle: endS, clockwise: true)
        // 进度
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        //添加到中心点的连线
        path.addLineToPoint(center)
        path.closePath()
        
        UIColor.orangeColor().setFill()
        UIColor.orangeColor().setStroke()
       
        path.fill()
        pathStroke.stroke()
      
    }
}