//
//  JournalViewController.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-18.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class JournalVC: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var arrayOfQuestions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBackground()
        setupQuestions()
        
        myTableView.estimatedRowHeight = 44
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        myTableView.allowsSelection = false
    }

    func setupQuestions(){
        let question1 = Question(statement: "How intense are these emotions?", type:  .RadioButton)
        arrayOfQuestions.append(question1)
        let question2 = Question(statement: "Where are you?", type:  .TextField)
        arrayOfQuestions.append(question2)
        let question3 = Question(statement: "What are things you can see, touch, or smell?", type:  .TextField)
        arrayOfQuestions.append(question3)
        let question4 = Question(statement: "What were you doing before you began this session of emotional training?", type:  .TextField)
        arrayOfQuestions.append(question4)
        let question5 = Question(statement: "Describe the people in your environment?", type:  .TextField)
        arrayOfQuestions.append(question5)
        let question6 = Question(statement: "Are you around loved one, acquaintance, strangers?", type:  .TextField)
        arrayOfQuestions.append(question6)
        let question7 = Question(statement: "How are the people in your world affected by your emotional state?", type:  .TextField)
        arrayOfQuestions.append(question7)
        let question8 = Question(statement: "Tell me a win today.", type:  .TextField)
        arrayOfQuestions.append(question8)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfQuestions.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if arrayOfQuestions[indexPath.row].type == QuestionTypes.RadioButton {
            if let tempCell = myTableView.dequeueReusableCellWithIdentifier("RadioButtonQuestion", forIndexPath: indexPath) as? RadioButtonwCell {
                tempCell.backgroundColor = Feelz.sharedInstance.getBrightColour()
                tempCell.radioButtons.tintColor = Feelz.sharedInstance.getDarkColour()
            }
        } else if arrayOfQuestions[indexPath.row].type == QuestionTypes.TextField {
            if let tempCell = myTableView.dequeueReusableCellWithIdentifier("TextFieldQuestion", forIndexPath: indexPath) as? TextFieldCell {
                tempCell.backgroundColor = Feelz.sharedInstance.getBrightColour()
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var returnCell = UITableViewCell()
        if arrayOfQuestions[indexPath.row].type == .RadioButton {
            if let tempCell = myTableView.dequeueReusableCellWithIdentifier("RadioButtonQuestion", forIndexPath: indexPath) as? RadioButtonwCell {
                tempCell.questionLabel?.text = arrayOfQuestions[indexPath.row].statement
                tempCell.backgroundColor = Feelz.sharedInstance.getBrightColour()
                returnCell = tempCell
            }
        } else if arrayOfQuestions[indexPath.row].type == .TextField {
            if let tempCell = myTableView.dequeueReusableCellWithIdentifier("TextFieldQuestion", forIndexPath: indexPath) as? TextFieldCell {
                tempCell.questionLabel?.text = arrayOfQuestions[indexPath.row].statement
                tempCell.backgroundColor = Feelz.sharedInstance.getBrightColour()
                returnCell = tempCell
            }
        }
        return returnCell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkBackground()
        myTableView.reloadData()
        view.layoutIfNeeded()
    }
    
    func checkBackground(){
        view.backgroundColor = Feelz.sharedInstance.getBrightColour()
        myTableView.backgroundColor = Feelz.sharedInstance.getBrightColour()
    }

}
