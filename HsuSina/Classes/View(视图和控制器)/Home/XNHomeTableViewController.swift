//
//  XNHomeTableViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNHomeTableViewController: XNVisitorTableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupInfo(nil,title: "关注一些人，回这里看看有什么惊喜")
    }

    
}
