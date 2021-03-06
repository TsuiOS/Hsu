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
/// 转发微博的可重用 ID
let XNStatusCellRetweetedId = "XNStatusCellRetweetedId"

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
        
        // 注册通知 
        NSNotificationCenter.defaultCenter().addObserverForName(XNStatusSelectedPhotoNotification,
            object: nil,
            queue: nil) { [weak self](n) -> Void in
                
                guard let indexPath = n.userInfo?[XNStatusSelectedPhotoIndexPathKey] as? NSIndexPath else {
                    return
                }
                
                guard let urls = n.userInfo?[XNStatusSelectedPhotoURLsKey] as? [NSURL] else {
                
                    return
                }
                
                let vc = XNPhotoBrowserViewController(urls: urls, indexPath: indexPath)
                
                // modal
                self?.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    deinit {
        // 注销通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
    ///  准备表格
    private func preferTableView() {
        
        //注册可重用 cell
        tableView.registerClass(XNStatusNormalCell.self, forCellReuseIdentifier: XNStatusCellNormalId)
        tableView.registerClass(XNStatusRetweetedCell.self, forCellReuseIdentifier: XNStatusCellRetweetedId)
        
        //取消分割线
        tableView.separatorStyle = .None
        
        //预估行高
        tableView.estimatedRowHeight = 400
        
        // 下拉刷新控件默认没有
        refreshControl = XNRefreshControl()
        
        //添加监听方法
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        // 测试代码
        refreshControl?.tintColor = UIColor.clearColor()
    
    }
    
    
    ///  加载数据
    @objc private func loadData() {
        
        listViewModel.loadStatus { (isSuccessed) -> () in
            
            // 关闭刷新控件
            self.refreshControl?.endRefreshing()
            
            if !isSuccessed {
                SVProgressHUD.showInfoWithStatus("数据加载失败,请稍后再试")
                return
            }
            //测试数据
//            print(self.listViewModel.statusList)pri
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
       
        //1. 获取视图模型
        let vm = listViewModel.statusList[indexPath.row]
        
        //2. 获取可重用 cell 会自动调用行高方法
        let cell = tableView.dequeueReusableCellWithIdentifier(vm.cellID, forIndexPath: indexPath) as! XNStatusCell
        
        cell.viewModel = vm
        return cell
    }
    // 如果行高是固定值,就不要实现行高代理方法
    // 实际开发中,行高一定要缓存
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return listViewModel.statusList[indexPath.row].rowHeight
    }

}
