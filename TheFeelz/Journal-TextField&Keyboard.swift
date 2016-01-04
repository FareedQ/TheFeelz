//
//  Journal-TextField&Keyboard.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-29.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

extension JournalVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func registerForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func degregisterForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification){
        guard let
            kbSizeValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
            else {return}
        let kbHeight = kbSizeValue.CGRectValue().height
        animateToKeyboardHeight(kbHeight, duration: kbDurationNumber.doubleValue)
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        guard let
            kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
            else {return}
        animateToKeyboardHeight(tabBarPadding - bottomPadding, duration: kbDurationNumber.doubleValue)
    }
    
    func animateToKeyboardHeight(kbHeight: CGFloat, duration: Double){
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.bottomMapLayoutConstraint.constant = kbHeight + self.bottomPadding - self.tabBarPadding
            self.view.layoutIfNeeded()
            }) { (complete) -> Void in
                
        }
    }
    
}
