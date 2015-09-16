//  AppDelegate.swift
//  HuBa
//
//  Created by dongjun on 15/9/14.
//  Copyright (c) 2015年 dongjun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
        
        var tab:UITabBarController = UITabBarController()
        
        var view1:MenuController = MenuController()
        
        var view2:NewsController = NewsController()
        
        var view3:SetController = SetController()
        
        self.initChild("首页", image1:"001", image2: "", childController: view1, tab: tab)
        
        self.initChild("资讯", image1: "002", image2: "", childController: view2, tab: tab)
        
        self.initChild("设置", image1: "003", image2: "", childController: view3, tab: tab)
        
        self.window?.makeKeyAndVisible()
        
        self.window?.rootViewController = tab
        
        return true
    }
    
    func initChild(title:String,image1:String,image2:String,childController:UIViewController,tab:UITabBarController){
        
        childController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: image1), selectedImage: UIImage(named: image2))
        
        var nav:UINavigationController = UINavigationController()
        
        nav.addChildViewController(childController);
        
        tab.addChildViewController(nav)
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

