//
//  Journal-TableView.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-29.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

extension JournalVC: UITableViewDataSource, UITableViewDelegate  {
    
    func setupTableView(){
        myTableView.estimatedRowHeight = 44
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        myTableView.allowsSelection = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfQuestions.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if arrayOfQuestions[indexPath.row].type == QuestionTypes.RadioButton {
            if var tempCell = myTableView.dequeueReusableCellWithIdentifier("RadioButtonQuestion", forIndexPath: indexPath) as? RadioButtonwCell {
                setupRadioButtonCell(&tempCell, indexPath: indexPath)
            }
        } else if arrayOfQuestions[indexPath.row].type == QuestionTypes.TextField {
            if var tempCell = myTableView.dequeueReusableCellWithIdentifier("TextFieldQuestion", forIndexPath: indexPath) as? TextFieldCell {
                setupTextFieldCell(&tempCell, indexPath: indexPath)
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var returnCell = UITableViewCell()
        if arrayOfQuestions[indexPath.row].type == .RadioButton {
            if var tempCell = myTableView.dequeueReusableCellWithIdentifier("RadioButtonQuestion", forIndexPath: indexPath) as? RadioButtonwCell {
                setupRadioButtonCell(&tempCell, indexPath: indexPath)
                returnCell = tempCell
            }
        } else if arrayOfQuestions[indexPath.row].type == .TextField {
            if var tempCell = myTableView.dequeueReusableCellWithIdentifier("TextFieldQuestion", forIndexPath: indexPath) as? TextFieldCell {
                setupTextFieldCell(&tempCell, indexPath: indexPath)
                returnCell = tempCell
            }
        }
        return returnCell
    }
    
    func setupRadioButtonCell(inout tempCell:RadioButtonwCell, indexPath:NSIndexPath){
        tempCell.questionLabel?.text = arrayOfQuestions[indexPath.row].statement
        tempCell.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        tempCell.questionLabel.textColor = Feelz.sharedInstance.getFontColour()
        tempCell.radioButtons.tintColor = Feelz.sharedInstance.getFontColour()
        tempCell.loadSelections(arrayOfQuestions[indexPath.row].segements)
    }
    
    func setupTextFieldCell(inout tempCell:TextFieldCell, indexPath:NSIndexPath){
        tempCell.questionLabel?.text = arrayOfQuestions[indexPath.row].statement
        tempCell.backgroundColor = Feelz.sharedInstance.getBackgroundColour()
        tempCell.questionLabel.textColor = Feelz.sharedInstance.getFontColour()
        tempCell.inputTextFeild.delegate = self
        
        //had a problem with the final textfield kept loading the value from the first one. Needed to put this hack in place for the demo day
        if indexPath.row == arrayOfQuestions.count - 1 {
            tempCell.inputTextFeild.text = ""
        }
    }
    
}
