//
//  HistoryTodayController.swift
//  HuBa
//
//  Created by dongjun on 15/9/18.
//  Copyright © 2015年 dongjun. All rights reserved.
//

import UIKit
import Alamofire

class HistoryTodayController: UIViewController {

    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "历史上的今天"
        
        // 定义一个按钮，回到默认日期
        let button1 = UIButton()
        button1.frame = CGRectMake(self.view.frame.width/2 - 200, 50, 400, 50)
        button1.setTitle("回到默认日期", forState: UIControlState.Normal)
        button1.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button1.tag = 1
        
        // 定义一个按钮，打印当前选中的日期
        let button2 = UIButton()
        button2.frame = CGRectMake(self.view.frame.width/2 - 200, 100, 400, 50)
        button2.setTitle("查询历史上的今天", forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button2.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.tag = 2
        
        // 初始化 datePicker
        datePicker = UIDatePicker(frame: CGRectMake(0, self.view.frame.height - 300, self.view.frame.width, 300))
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.Date
        // 设置分钟表盘的时间间隔（必须能让60整除，默认是1分钟）
        datePicker.minuteInterval = 5
        // 设置日期范围（超过日期范围，会回滚到最近的有效日期）
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let maxDate = dateFormatter.dateFromString("2015-12-31")
        let minDate = dateFormatter.dateFromString("2015-01-01")
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        // 设置默认时间
        datePicker.date = NSDate()
        // 响应事件（只要滚轮变化就会触发）
        datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(datePicker)
    }
    
    /// 响应按钮点击事件
    func buttonAction(sender: UIButton) {
        let num = sender.tag
        switch num {
        case 1:
            // 回到默认日期
            datePicker.setDate(NSDate(), animated: true)
        case 2:
            // 打印当前选中的日期
            print("当前日期：\(datePicker.date)")
            
            let list:HistoryTodayListController = HistoryTodayListController()
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            list.dataString = dateFormatter.stringFromDate(datePicker.date)
            self.navigationController?.pushViewController(list, animated: false)
        default:
            break
        }
    }
    
    /// 响应 datePicker 事件
    func datePickerValueChange(sender: UIDatePicker) {
        print("date select: \(sender.date)")
    }

}
