//
//  HotTravelController.swift
//  HuBa
//
//  Created by dongjun on 15/9/18.
//  Copyright © 2015年 dongjun. All rights reserved.
//

import UIKit
import Alamofire

class HotTravelController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    var dataArray:NSArray!
    
    var query:UITextField!
    
    var table:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "热门游记"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.dataArray = NSArray()
        
        self.createUI()
    }
    
    //创建视图
    func createUI(){
        self.query = UITextField(frame: CGRectMake(10, 65, self.view.frame.size.width-100, 40))
        self.query.placeholder = "请输入景点名称"
        //self.query.keyboardType = UIKeyboardType.PhonePad
        self.query.delegate = self
        self.view.addSubview(self.query)
        
        let btn:UIButton = UIButton(frame: CGRectMake(self.view.frame.size.width-100, 65, 80, 40))
        btn.setTitle("查询", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action:Selector("search:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        self.table = UITableView(frame: CGRectMake(0, 110, self.view.frame.size.width-20, self.view.frame.size.height-120))
        self.table.delegate = self
        self.table.dataSource = self
        self.table.tableFooterView = UIView()
        self.view.addSubview(self.table)
    }
    
    func search(btn:UIButton){
        self.query.resignFirstResponder()
        let dic:NSDictionary = ["query":self.query.text as! NSString,"page":"1"]
        Alamofire.request(.GET,"http://apis.baidu.com/qunartravel/travellist/travellist",parameters:(dic as! [String : AnyObject]))
            .responseJSON { _, _, result in
                
                let dic:NSDictionary = result.value as!NSDictionary
                print(dic)
                let dataDic = dic["data"] as! NSDictionary
                self.dataArray = dataDic["books"] as! NSArray
                self.table.reloadData()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.query.resignFirstResponder()
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
        cell.textLabel?.text = dic["title"] as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hotDetail:HotTravelWebDetailController = HotTravelWebDetailController()
        let dic:NSDictionary = self.dataArray[indexPath.row] as! NSDictionary
        hotDetail.webUrl = dic["bookUrl"] as! String
        hotDetail.title = "详细介绍"
        self.navigationController?.pushViewController(hotDetail, animated: false)
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
