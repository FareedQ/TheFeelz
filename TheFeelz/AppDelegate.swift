//
//  AppDelegate.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-17.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        User.sharedInstance.load()
        return true
        
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        loadFromLocalNotification()
    }
    
    
    func applicationWillTerminate(application: UIApplication) {
        User.sharedInstance.save()
    }
    
    func loadFromLocalNotification(){
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("myViewController")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }

}

