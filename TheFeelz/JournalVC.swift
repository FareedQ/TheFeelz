//
//  JournalViewController.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-18.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class JournalVC: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var bottomMapLayoutConstraint: NSLayoutConstraint!
    
    var arrayOfQuestions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewToLookPretty()
        setupQuestions()
        setupTableView()
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        degregisterForKeyboardNotifications()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViewToLookPretty()
        myTableView.reloadData()
        view.layoutIfNeeded()
    }
    
    func setupViewToLookPretty(){
        view.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        myTableView.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        TitleLabel.textColor = Feelz.sharedInstance.getFontColour()
    }
}
