//
//  MenuController.swift
//  HuBa
//
//  Created by dongjun on 15/9/14.
//  Copyright (c) 2015年 dongjun. All rights reserved.
//

import UIKit

class MenuController: UIViewController,UIScrollViewDelegate {

    var pc: UIPageControl!
    var sv:UIScrollView!
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "首页"
        self.view.backgroundColor = UIColor.whiteColor()
        
       
        sv = UIScrollView(frame: CGRectMake(0, 60, self.view.frame.size.width, 200))
        
        pc = UIPageControl(frame: CGRectMake(self.view.frame.size.width/2-25, 240, 50, 20))
        
        self.view.addSubview(sv)
        self.view.addSubview(pc)
        
        
       
        for i in 1...6{ //loading the images
                let image = UIImage(named: "pic\(i).jpg")!
                let x = CGFloat(i - 1) * self.view.frame.width //这一步获取ScrollView的宽度时我用IPHONE6实体机测试是320，右边会出现第二张图片的一部分，最后还是用ROOT VIEW的宽度
                let imageView = UIImageView(frame: CGRectMake(x, 0, self.view.frame.width, sv.bounds.height))
                imageView.image = image
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                sv.pagingEnabled = true
                sv.showsHorizontalScrollIndicator = false
                sv.scrollEnabled = true
                sv.addSubview(imageView)
                sv.delegate = self
        }
            
        sv.contentSize = CGSizeMake((self.view.frame.width * 6), sv.frame.height)
        pc.numberOfPages = 6
        pc.currentPageIndicatorTintColor = UIColor.redColor()
        pc.pageIndicatorTintColor = UIColor.whiteColor()
        addTimer()
        
        
        self.createUI()
            
    }
    
    func createUI(){
        for i in 0...1 {
            let btn:UIButton = UIButton(frame: CGRectMake(CGFloat(i)*(self.view.frame.size.width/2), 265, self.view.frame.size.width/2, (self.view.frame.size.height-320)/3))
//            btn.setTitle("按钮", forState: UIControlState.Normal)
//            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//            btn.layer.borderWidth = 1
//            btn.layer.borderColor = UIColor.blackColor().CGColor
            btn.setBackgroundImage(UIImage(named: "btn1.jpeg"), forState:UIControlState.Normal)
            btn.tag = NSInteger(i)
            btn.addTarget(self, action:Selector("getData:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(btn)
        }
        
        for i in 0...1 {
            let btn:UIButton = UIButton(frame: CGRectMake(CGFloat(i)*(self.view.frame.size.width/2), 265+(self.view.frame.size.height-320)/3, self.view.frame.size.width/2, (self.view.frame.size.height-320)/3))
//            btn.setTitle("按钮", forState: UIControlState.Normal)
//            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//            btn.layer.borderWidth = 1
//            btn.layer.borderColor = UIColor.blackColor().CGColor
            btn.tag = NSInteger(i)+2
            btn.addTarget(self, action:Selector("getData:"), forControlEvents: UIControlEvents.TouchUpInside)
            btn.setBackgroundImage(UIImage(named: "btn1.jpeg"), forState:UIControlState.Normal)
            self.view.addSubview(btn)
        }
        
        for i in 0...1 {
            let btn:UIButton = UIButton(frame: CGRectMake(CGFloat(i)*(self.view.frame.size.width/2), 265+(self.view.frame.size.height-320)/3*2, self.view.frame.size.width/2, (self.view.frame.size.height-320)/3))
            //            btn.setTitle("按钮", forState: UIControlState.Normal)
            //            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            //            btn.layer.borderWidth = 1
            //            btn.layer.borderColor = UIColor.blackColor().CGColor
            btn.tag = NSInteger(i)+4
            btn.setBackgroundImage(UIImage(named: "btn1.jpeg"), forState:UIControlState.Normal)
            self.view.addSubview(btn)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getData(btn:UIButton){
        switch(btn.tag){
        case 0:
            let phone:PhoneAddressController = PhoneAddressController()
            phone.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(phone, animated: false)
            break
        case 1:
            let today:HistoryTodayController = HistoryTodayController()
            today.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(today, animated: false)
            break
        case 2:
            let hot:HotTravelController = HotTravelController()
            hot.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(hot, animated: false)
            break
        default:
            ""
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let width = self.view.frame.width
        let offsetX = scrollView.contentOffset.x
        let index = (offsetX + width / 2) / width
        pc.currentPage = Int(index)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "nextImage", userInfo: nil, repeats: true)
    }
    
    func removeTimer() {
        timer.invalidate()
    }
    
    
    func nextImage() {
        var pageIndex = pc.currentPage
        if pageIndex == 5 {
            pageIndex = 0
        } else {
            pageIndex++
        }
        
        let offsetX = CGFloat(pageIndex) * self.view.frame.width
        sv.setContentOffset(CGPointMake(offsetX, 0), animated: true)
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
