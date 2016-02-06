//
//  XNHomeTableViewController.swift
//  HsuSina
//
//  Created by mac on 16/1/24.
//  Copyright © 2016年 Hsu. All rights reserved.
//
///  249 
import UIKit
import SVProgressHUD

/// 微博 Cell 的可重用表示符号
let XNStatusCellNormalId = "XNStatusCellNormalId"

class XNHomeTableViewController: XNVisitorTableViewController {

    /// 微博数据列表模型
    private lazy var listViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserAccountViewModel.sharedUserAccount.userLogon {
        visitorView?.setupInfo(nil,title: "关注一些人，回这里看看有什么惊喜")
        
         return
        }
        preferTableView()
        
        loadData()
    }
    ///  准备表格
    private func preferTableView() {
        
        //注册可重用 cell
        tableView.registerClass(XNStatusCell.self, forCellReuseIdentifier: XNStatusCellNormalId)
        //取消分割线
        tableView.separatorStyle = .None
        
        //预估行高
        tableView.estimatedRowHeight = 400
    
    }
    
    ///  加载数据
    private func loadData() {
        
        listViewModel.loadStatus { (isSuccessed) -> () in
            if !isSuccessed {
                SVProgressHUD.showInfoWithStatus("数据加载失败,请稍后再试")
                return
            }
            //测试数据
            print(self.listViewModel.statusList)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(XNStatusCellNormalId, forIndexPath: indexPath) as! XNStatusCell
        
        cell.viewModel = listViewModel.statusList[indexPath.row]
        
        return cell
    }
    // 如果行高是固定值,就不要实现行高代理方法
    // 实际开发中,行高一定要缓存
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return listViewModel.statusList[indexPath.row].rowHeight
    }

}
