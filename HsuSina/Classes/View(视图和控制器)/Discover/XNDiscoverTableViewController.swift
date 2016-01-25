//
//  XNDiscoverTableViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNDiscoverTableViewController: XNVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupInfo("visitordiscover_image_message",title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
    }

    
}
