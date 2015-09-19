//
//  HistoryDetailController.swift
//  HuBa
//
//  Created by dongjun on 15/9/18.
//  Copyright © 2015年 dongjun. All rights reserved.
//

import UIKit

class HistoryDetailController: UIViewController {

    var content:String!
    var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView  = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.textView.editable = false
        self.textView.text = self.content
        self.view.addSubview(self.textView)
        // Do any additional setup after loading the view.
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
