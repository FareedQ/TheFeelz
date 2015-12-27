//
//  UserModel.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-26.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class User: NSObject {
    
    //Setup Defaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    //Accessable Variables
    var introJournalScreenGiven = false
    
    //Internal Datatypes
    internal var introJournalScreenGivenDataType:Bool?
    
    func save(){
        defaults.setValue(introJournalScreenGiven, forKey: "introJournalScreenGiven")
        defaults.synchronize()
    }
    
    func load() {
        if let object = defaults.objectForKey("introJournalScreenGiven") as? Bool {
            introJournalScreenGiven = object
        }
    }

    
}
