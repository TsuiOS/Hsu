//
//  XNPhotoBrowserViewController.swift
//  HsuSina
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit

class XNPhotoBrowserViewController: UIViewController {

    ///  照片 url 数组
    private var urls: [NSURL]
    ///  当前选中的照片索引
    private var currentIndexPath: NSIndexPath
    
    // MARK : - 构造函数
    init(urls: [NSURL], indexPath: NSIndexPath) {
        self.urls = urls
        self.currentIndexPath = indexPath
        
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(urls)
        print(currentIndexPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
