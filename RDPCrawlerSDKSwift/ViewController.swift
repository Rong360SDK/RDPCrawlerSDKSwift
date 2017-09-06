//
//  ViewController.swift
//  RDPCrawlerSDKSwift
//
//  Created by Liudequan on 2017/9/6.
//  Copyright © 2017年 R360. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var sourceArray:NSMutableArray = []
    var tblView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "抓取demo";
        self.tblView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain);
        self.tblView?.register(UITableViewCell.self, forCellReuseIdentifier:"cellIndentifier")
        self.view.addSubview(self.tblView!);
        self.tblView?.delegate = self;
        self.tblView?.dataSource = self;
        
        self.sourceArray = NSMutableArray.init(array: [kRDPCrawlerTypeAlipay,kRDPCrawlerTypeTaobao,kRDPCrawlerTypeOperator]);
        self.tblView?.reloadData();
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIndentifier = "cellIndentifier";
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier);
        
        var title = "";
        let  number = self.sourceArray.object(at: indexPath.row) as! kRDPCrawlerType;
        switch (number) {
        case kRDPCrawlerTypeAlipay:
            title = "支付宝抓取";
            break;
        case kRDPCrawlerTypeTaobao:
            title = "淘宝抓取";
            break;
        case kRDPCrawlerTypeOperator:
            title = "运营商抓取";
            break;
        default:
            break;
        }
        
        cell?.textLabel?.text = title;
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView?.deselectRow(at: indexPath, animated: true);
        
        let  number = self.sourceArray.object(at: indexPath.row) as! kRDPCrawlerType;
        let taskId = String.init(format: "%ld", indexPath.row);
        switch (number) {
        case kRDPCrawlerTypeAlipay,kRDPCrawlerTypeTaobao:
            RDPCrawlerManager.startCrawler(by: number, identifier: taskId, addtionalParams: nil)
        break;
        case kRDPCrawlerTypeOperator:
            let config = RDPC_OperatorConfig() as RDPC_OperatorConfig;
            config.phone = "13738061365";
            config.canEditPhone = true;
            RDPCrawlerManager.startCrawlerOperator(by: config, identifier: taskId, addtionalParams: nil);
            break;
        default:
            break;
        }
    }

}

