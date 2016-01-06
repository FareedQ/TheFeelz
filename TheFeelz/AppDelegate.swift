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
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        setupANotification()
        
        return true
        
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        loadFromLocalNotification()
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        loadFromLocalNotification()
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        loadFromLocalNotification()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        User.sharedInstance.save()
        Feelz.sharedInstance.save()
    }

}

