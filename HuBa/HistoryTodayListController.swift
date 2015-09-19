//
//  HistoryTodayListController.swift
//  HuBa
//
//  Created by dongjun on 15/9/18.
//  Copyright © 2015年 dongjun. All rights reserved.
//

import UIKit
import Alamofire

class HistoryTodayListController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    var dataString:String!

    var dataArray:NSArray!
    
    var table:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataArray = NSArray()
        
        self.table = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.table.delegate = self
        self.table.dataSource = self
        self.view.addSubview(self.table)
        // Do any additional setup after loading the view.
        
        self.loadData()
    }
    
    func loadData(){
        
        let arr:NSArray = self.dataString.componentsSeparatedByString("-")
        let dic:NSDictionary = ["month":arr[1],"day":arr[2],"appkey":"1307ee261de8bbcf83830de89caae73f"]
        Alamofire.request(.GET,"http://apis.baidu.com/netpopo/todayhistory/todayhistory",parameters:(dic as! [String : AnyObject]))
            .responseJSON { _, _, result in
                
                let dic:NSDictionary = result.value as!NSDictionary
                print(dic)
                self.dataArray = dic["data"] as! NSArray
                self.table.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        let dic:NSDictionary = self.dataArray[indexPath.row] as! NSDictionary
        cell.textLabel?.text = dic["name"] as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hisDetail:HistoryDetailController = HistoryDetailController()
        let dic:NSDictionary = self.dataArray[indexPath.row] as! NSDictionary
        hisDetail.content = dic["content"] as! String
        hisDetail.title = "详情"
        self.navigationController?.pushViewController(hisDetail, animated: false)
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
