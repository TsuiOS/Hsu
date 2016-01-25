//
//  XNMessageTableViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNMessageTableViewController: XNVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupInfo("visitordiscover_image_message",title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
 
    }


}
