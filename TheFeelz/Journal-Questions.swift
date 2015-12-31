//
//  Journal-Questions.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-29.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

extension JournalVC {
    
    func setupQuestions(){
        let question1 = Question(statement: "How intense are these emotions?", type:  .RadioButton, segements: ["mild","fair","decent","strong","intense"])
        arrayOfQuestions.append(question1)
        let question2 = Question(statement: "Where are you?", type:  .TextField, segements: [])
        arrayOfQuestions.append(question2)
        let question3 = Question(statement: "What are things you can see, touch, or smell?", type:  .TextField, segements: [])
        arrayOfQuestions.append(question3)
        let question4 = Question(statement: "How would you classify what you are doing?", type:  .RadioButton, segements: ["Work","Leisure","Chores","Travel","Other"])
        arrayOfQuestions.append(question4)
        let question5 = Question(statement: "Describe the people in your environment?", type:  .TextField, segements: [])
        arrayOfQuestions.append(question5)
        let question6 = Question(statement: "Who are you with?", type:  .RadioButton, segements: ["Alone","Loved one", "Strangers"])
        arrayOfQuestions.append(question6)
        let question7 = Question(statement: "How are the people in your world affected by your emotional state?", type:  .TextField, segements: [])
        arrayOfQuestions.append(question7)
        let question8 = Question(statement: "Tell me a win today.", type:  .TextField, segements: [])
        arrayOfQuestions.append(question8)
    }
    
}
