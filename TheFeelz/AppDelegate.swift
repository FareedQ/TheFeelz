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

    // Declaring a singleton
    // There is probably better practice, this is how we learned in class
    //let myFeelz = Feelz()
    let myUser = User()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        myUser.load()
        return true
        
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        loadFromLocalNotification()
    }
    
    
    func loadFromLocalNotification(){
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("myViewController")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }

}

