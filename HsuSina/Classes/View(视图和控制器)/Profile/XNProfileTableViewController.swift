//
//  XNProfileTableViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNProfileTableViewController: XNVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupInfo("visitordiscover_image_profile",title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }
}
