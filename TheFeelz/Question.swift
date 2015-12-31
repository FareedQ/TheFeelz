//
//  QuestionModel.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-26.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

enum QuestionTypes{
    case RadioButton
    case TextField
}

struct Question {

    var statement = ""
    var type:QuestionTypes
    var segements = [String]()
}
