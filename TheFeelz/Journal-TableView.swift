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
                
                tempCell.loadSelections(arrayOfQuestions[indexPath.row].segements)
                
                returnCell = tempCell
            }
        } else if arrayOfQuestions[indexPath.row].type == .TextField {
            if let tempCell = myTableView.dequeueReusableCellWithIdentifier("TextFieldQuestion", forIndexPath: indexPath) as? TextFieldCell {
                tempCell.questionLabel?.text = arrayOfQuestions[indexPath.row].statement
                tempCell.backgroundColor = Feelz.sharedInstance.getBrightColour()
                tempCell.inputTextFeild.delegate = self
                returnCell = tempCell
            }
        }
        return returnCell
    }
    
}
