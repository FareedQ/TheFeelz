//
//  UserModel.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-26.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class User: NSObject {
    
    struct Static {
        static let instance = User()
    }

    class var sharedInstance: User {
        return Static.instance
    }

    //Setup Defaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //User settings
    var sleepTime:NSDate?
    var wakeTime:NSDate?
    
    func save(){
        defaults.setValue(sleepTime, forKey: "sleepTime")
        defaults.setValue(wakeTime, forKey: "wakeTime")
        defaults.synchronize()
    }
    
    func load() {
        if let object = defaults.objectForKey("sleepTime") as? NSDate { sleepTime = object }
        if let object = defaults.objectForKey("wakeTime") as? NSDate { wakeTime = object }
        
    }

    
}
