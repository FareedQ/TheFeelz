//
//  TexFeildTableViewCell.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-26.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var inputTextFeild: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
