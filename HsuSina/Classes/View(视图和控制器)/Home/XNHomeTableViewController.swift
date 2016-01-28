//
//  XNHomeTableViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 微博 Cell 的可重用表示符号
private let XNStatusCellNormalId = "XNStatusCellNormalId"

class XNHomeTableViewController: XNVisitorTableViewController {

    /// 微博数据列表模型
    private lazy var listViewModel = StatusesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupInfo(nil,title: "关注一些人，回这里看看有什么惊喜")
        
        preferTableView()
        
        loadData()
    }
    ///  准备表格
    private func preferTableView() {
        //注册可重用 cell
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: XNStatusCellNormalId)
    
    }
    
    ///  加载数据
    private func loadData() {
        
        listViewModel.loadStatus { (isSuccessed) -> () in
            if !isSuccessed {
                SVProgressHUD.showInfoWithStatus("数据加载失败,请稍后再试")
                return
            }
            //4. 刷新数据
            self.tableView.reloadData()
        }
        
    }
}

// MARK: - 数据源方法
extension XNHomeTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(XNStatusCellNormalId, forIndexPath: indexPath)
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
        return cell
    }

}
