//
//  SettingsViewController.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-17.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var sleepDatePicker: UIDatePicker!
    @IBOutlet weak var wakeDatePicker: UIDatePicker!
    @IBOutlet weak var wakeTitleLabel: UILabel!
    @IBOutlet weak var wakeView: UIView!
    @IBOutlet weak var wakeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sleepTitleLabel: UILabel!
    @IBOutlet weak var sleepView: UIView!
    @IBOutlet weak var sleepViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var sleepHidden = true
    var wakeHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideSleepDP()
        hideWakeDP()
        
        if let wakeTime = User.sharedInstance.wakeTime {
            wakeTitleLabel.text = "I wake up at " + displayTime(wakeTime)
            wakeDatePicker.date = wakeTime
        } else {
            User.sharedInstance.wakeTime = returnAnNSDateForTodayAt8am()
            guard let wakeTime = User.sharedInstance.wakeTime else { return }
            wakeTitleLabel.text = "I wake up at " + displayTime(wakeTime)
            wakeDatePicker.date = wakeTime
        }
        
        if let sleepTime = User.sharedInstance.sleepTime {
            sleepTitleLabel.text = "I go to sleep at " + displayTime(sleepTime)
            sleepDatePicker.date = sleepTime
        } else {
            User.sharedInstance.sleepTime = returnAnNSDateForTodayAt10pm()
            guard let sleepTime = User.sharedInstance.sleepTime else { return }
            sleepTitleLabel.text = "I go to sleep at " + displayTime(sleepTime)
            sleepDatePicker.date = sleepTime
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    func returnAnNSDateForTodayAt10pm() -> NSDate {
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components = calendar.components([.Hour , .Minute], fromDate: date)
        components.hour = 22
        components.minute = 0
        guard let newDate = calendar.dateFromComponents(components) else { return NSDate() }
        return newDate
    }
    
    func returnAnNSDateForTodayAt8am() -> NSDate {
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components = calendar.components([.Hour , .Minute], fromDate: date)
        components.hour = 8
        components.minute = 0
        guard let newDate = calendar.dateFromComponents(components) else { return NSDate() }
        return newDate
    }
    
    override func viewWillAppear(animated: Bool) {
        hideSleepDP()
        hideWakeDP()
    }
    
    func tapGesture(sender: UITapGestureRecognizer){
        
        if sleepTitleLabel.frame.contains(sender.locationInView(view)) {
            if sleepHidden {
                sleepHidden = false
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.hideWakeDP()
                    self.showSleepDP()
                    self.view.layoutIfNeeded()
                })
                wakeHidden = true
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.hideSleepDP()
                    self.view.layoutIfNeeded()
                })
                sleepHidden = true
            }
        }
        
        if wakeTitleLabel.frame.contains(sender.locationInView(view)) {
            if wakeHidden {
                wakeHidden = false
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.hideSleepDP()
                    self.showWakeDP()
                    self.view.layoutIfNeeded()
                })
                sleepHidden = true
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.hideWakeDP()
                    self.view.layoutIfNeeded()
                })
                wakeHidden = true
            }
        }
    }
    
    func hideWakeDP(){
        wakeView.alpha = 0
        wakeViewHeightConstraint.constant = 0
    }
    
    func showWakeDP() {
        wakeView.alpha = 1
        wakeViewHeightConstraint.constant = 185
    }
    
    func hideSleepDP(){
        sleepView.alpha = 0
        sleepViewHeightConstraint.constant = 0
    }
    
    func showSleepDP(){
        sleepView.alpha = 1
        sleepViewHeightConstraint.constant = 185
    }
    
    @IBAction func setupAlertButton(sender: UIButton) {
        setupTimeBasedNotification()
    }
    
    func setupTimeBasedNotification(){
        
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
    
    @IBAction func sleepDatePickerAction(sender: UIDatePicker) {
        sleepTitleLabel.text = "I go to sleep at " + displayTime(sender.date)
        User.sharedInstance.sleepTime = sender.date
    }
    
    @IBAction func wakeDatePickerAction(sender: UIDatePicker) {
        wakeTitleLabel.text = "I wake up at " + displayTime(sender.date)
        User.sharedInstance.wakeTime = sender.date
    }
    
    func displayTime(date :NSDate) -> String {
        var returnString = String()
        
        let calendar = NSCalendar.currentCalendar()
        let component = calendar.components([.Hour, .Minute], fromDate: date)
        let beforeNoon = component.hour < 12
        let hour = component.hour%12
        let minute = component.minute
        if hour == 0 { returnString = "12:" }
        else { returnString = "\(hour):" }
        if minute == 0 { returnString += "00" }
        else { returnString += "\(minute)" }
        if beforeNoon { returnString += " am" }
        else { returnString += " pm" }
        
        return returnString
        
    }
    @IBAction func passwordButton(sender: UIButton) {
        if sender.titleLabel?.text == "Show Password" {
            sender.setTitle("Hide Passowrd", forState: .Normal)
            passwordTextField.secureTextEntry = false
            passwordTextField.font = UIFont(name: "OpenSans", size: 17)
        } else {
            sender.setTitle("Show Password", forState: .Normal)
            passwordTextField.secureTextEntry = true
            passwordTextField.font = UIFont(name: "OpenSans", size: 17)
        }
    }
}
