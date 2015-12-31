//
//  RadioButtonTableViewCell.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-26.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class RadioButtonwCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var radioButtons: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadSelections(selectionArray:[String]){
        if selectionArray.count == radioButtons.numberOfSegments { return }
    
        radioButtons.removeAllSegments()
        for selection in selectionArray.reverse() {
            radioButtons.insertSegmentWithTitle(selection, atIndex: 0, animated: false)
        }
    }

}
