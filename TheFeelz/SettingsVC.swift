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
    
    var sleepHidden = true
    var wakeHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideSleepDP()
        hideWakeDP()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(gestureRecognizer)
        
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
    
    func setupTimeBasedNotification(){
        
//        let formatter = NSDateFormatter()
//        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//        let localNotification = UILocalNotification()
//        localNotification.alertTitle = "Notification"
//        localNotification.alertBody = "Time Notification at \(formatter.stringFromDate(datePicker.date))"
//        localNotification.fireDate = datePicker.date
//        
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    @IBAction func sleepDatePickerAction(sender: UIDatePicker) {
        sleepTitleLabel.text = "I go to sleep at \(sender.date)"
    }
}
