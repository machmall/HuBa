//
//  PhoneAddressController.swift
//  HuBa
//
//  Created by dongjun on 15/9/14.
//  Copyright (c) 2015年 dongjun. All rights reserved.
//

import UIKit
import Alamofire

class PhoneAddressController: UIViewController ,UITextFieldDelegate{

    var phoneText:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "手机归属地查询"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createUI()
    }
    
    //创建视图
    func createUI(){
        self.phoneText = UITextField(frame: CGRectMake(10, 65, self.view.frame.size.width-100, 40))
        phoneText.placeholder = "请输入手机号"
        self.phoneText.delegate = self
        self.view.addSubview(self.phoneText)
        
        var btn:UIButton = UIButton(frame: CGRectMake(self.view.frame.size.width-100, 65, 80, 40))
        btn.setTitle("查询", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.view.addSubview(btn)
    }

     override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        Alamofire.request(.GET, "http://apis.baidu.com/apistore/mobilephoneservice/mobilephone?tel=18356092871").responseJSON() {
            (_, _, data, _) in
            println(data)
            
            var dic:NSDictionary = NSDictionary()
            dic = data?.valueForKey("retData") as! NSDictionary
            var arr:NSArray = dic.allKeys
            for i in 0...2{
            
                var la:UILabel = UILabel(frame: CGRectMake(10, 100+50*CGFloat(i), 200, 50))
                la.text = dic.valueForKey(arr[i] as! String) as? String
                self.view.addSubview(la)
            }
        }
        
        self.phoneText.resignFirstResponder()
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
