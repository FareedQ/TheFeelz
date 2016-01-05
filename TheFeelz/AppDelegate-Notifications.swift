//
//  AppDelegate-Notifications.swift
//  TheFeelz
//
//  Created by FareedQ on 2016-01-05.
//  Copyright © 2016 FareedQ. All rights reserved.
//

import UIKit

extension AppDelegate {

    func loadFromLocalNotification(){
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("SplashVC")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    func setupANotification(){
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let localNotification = UILocalNotification()
        localNotification.alertTitle = "Notification"
        localNotification.alertBody = "How are you feeling?"
        localNotification.fireDate = getARandomTimeToAlertTomorrow()
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func getARandomTimeToAlertTomorrow() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let NewDate = calendar.components([.Hour, .Minute, .Day], fromDate: NSDate())
        
        guard let givenWakeTime = User.sharedInstance.sleepTime else { return NSDate() }
        let wakeTime = calendar.components([.Hour, .Minute, .Day], fromDate: givenWakeTime)
        guard let givenSleepTime = User.sharedInstance.sleepTime else { return NSDate() }
        let sleepTime = calendar.components([.Hour, .Minute, .Day], fromDate: givenSleepTime)
        
        NewDate.day++
        NewDate.hour = Int(arc4random_uniform(UInt32(sleepTime.hour - wakeTime.hour)) + UInt32(sleepTime.hour))
        NewDate.minute = Int(arc4random_uniform(UInt32(sleepTime.minute - wakeTime.minute)) + UInt32(sleepTime.minute))
        
        guard let setupTime = calendar.dateFromComponents(NewDate) else {return NSDate()}
        
        return setupTime
    }
    
}
