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

    var blackBoard:UITextView!
    
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
        self.phoneText.placeholder = "请输入手机号"
        self.phoneText.keyboardType = UIKeyboardType.PhonePad
        self.phoneText.delegate = self
        self.view.addSubview(self.phoneText)
        
        let btn:UIButton = UIButton(frame: CGRectMake(self.view.frame.size.width-100, 65, 80, 40))
        btn.setTitle("查询", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action:Selector("search:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        self.blackBoard = UITextView(frame: CGRectMake(10, 120, self.view.frame.size.width-20, self.view.frame.size.height-120))
        self.blackBoard.font = UIFont.systemFontOfSize(25)
        self.view.addSubview(self.blackBoard)
    }

    func search(btn:UIButton){

        Alamofire.request(.GET,"http://apis.baidu.com/apistore/mobilephoneservice/mobilephone?tel=\(self.phoneText.text as! NSString)")
            .responseJSON { _, _, result in
                
                let dic:NSDictionary = result.value as!NSDictionary
                print(dic)
                
                let dics:NSDictionary = dic["retData"] as! NSDictionary
                let arr:NSArray = dics.allKeys as NSArray
                for i in 0...arr.count-1 {
                    var str:String = arr[i] as! String
                    str = dics[str] as! String
                    self.addText(str)
                }
         }
    }
    
     override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        
        /*Alamofire.request(.GET, "http://apis.baidu.com/apistore/mobilephoneservice/mobilephone", parameters: ["tel": "18356092871"])
            .response { request, response, data, error in
                print(data)
                
               // print(response)
               // print(error)
        }
        
        Alamofire.request(.GET, "http://apis.baidu.com/apistore/mobilephoneservice/mobilephone&tel=18356092871", headers: ["apikey":"ed800cafc0f1e3a8e2a922fa3b37d7c1"])
            .responseJSON { _, _, result in
                debugPrint(result)
        }*/
        
       
            
        self.phoneText.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addText(str:NSString){
        self.blackBoard.text = self.blackBoard.text.stringByAppendingString((str as? String)!)
    }

}
