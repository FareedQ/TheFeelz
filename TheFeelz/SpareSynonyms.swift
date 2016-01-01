//
//  SpareSynonyms.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-31.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

struct SpareSynonyms {
    
    var happy = ["joyful","interested","proud","accepted","powerful","peaceful","optimistic"]
    var sad = ["guilty","abandoned","depressed","lonely","bored"]
    var disgust = ["disappointed","awful","avoidance"]
    var angry = ["hurt","threatened","hateful","mad","aggressive","frustrated","distant","critical"]
    var fear = ["humiliated","rejected","submissive","insecure","anxious","scared"]
    
    func returnRandomSynonym(TypeOfWord:String, givenWords:[String]) -> String {
        switch TypeOfWord {
        case "Happy":
            var choosenWord = String()
            repeat {
                choosenWord = happy[Int(arc4random_uniform(UInt32(happy.count)))]
            } while givenWords.contains(choosenWord)
            return choosenWord
        case "Sad":
            var choosenWord = String()
            repeat {
                choosenWord = sad[Int(arc4random_uniform(UInt32(sad.count)))]
            } while givenWords.contains(choosenWord)
            return choosenWord
        case "Disgust":
            var choosenWord = String()
            repeat {
                choosenWord = disgust[Int(arc4random_uniform(UInt32(disgust.count)))]
            } while givenWords.contains(choosenWord)
            return choosenWord
        case "Angry":
            var choosenWord = String()
            repeat {
                choosenWord = angry[Int(arc4random_uniform(UInt32(angry.count)))]
            } while givenWords.contains(choosenWord)
            return choosenWord
        case "Fear":
            var choosenWord = String()
            repeat {
                choosenWord = fear[Int(arc4random_uniform(UInt32(fear.count)))]
            } while givenWords.contains(choosenWord)
            return choosenWord
        default:
            break
        }
        return ""
    }
}
