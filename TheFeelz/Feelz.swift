//
//  SelectedImage.swift
//  SelectionAnimation
//
//  Created by FareedQ on 2015-12-14.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

public class Feelz: NSObject {
    
    var emotionsArray = [Emotion]()
    var index:Int = 0
    
    
    struct Static {
        static let instance = Feelz()
    }
    
    class var sharedInstance: Feelz {
        return Static.instance
    }
    
    struct Emotion {
        var Name = String()
        var BrightColour = UIColor()
        var DarkColour = UIColor()
        var TextColour = UIColor()
    }
    
    let anger = Emotion(Name: "Anger", BrightColour: UIColorFromRGB("F40009"), DarkColour: UIColorFromRGB("480002"), TextColour: UIColorFromRGB("FCF0E6"))
    
    let disgust = Emotion(Name: "Disgust", BrightColour: UIColorFromRGB("23F307"), DarkColour: UIColorFromRGB("0F2D07"), TextColour: UIColorFromRGB("70B451"))
    //Disgust Bright 23F307
    //Disgust Dark 0F2D07
    //Disgust Text 70B451
    
    let fear = Emotion(Name: "Fear", BrightColour: UIColorFromRGB("C472FC"), DarkColour: UIColorFromRGB("20023E"), TextColour: UIColorFromRGB("DCBADC"))
    //Fear Bright C472FC
    //Fear Dark 20023E
    //Fear Text DCBADC
    
    let joy = Emotion(Name: "Joy", BrightColour: UIColorFromRGB("F6DC49"), DarkColour: UIColorFromRGB("D9890E"), TextColour: UIColorFromRGB("0F70F2"))
    //Joy Bright F6DC49
    //Joy Dark D9890E
    //Joy Text 0F70F2
    
    let sadness = Emotion(Name: "Sadness", BrightColour: UIColorFromRGB("49C2F7"), DarkColour: UIColorFromRGB("0A2363"), TextColour: UIColorFromRGB("B7D1E0"))
    //Sadness Dark 0A2363
    //Sadness Bright 49C2F7
    //Sadness text B7D1E0
    
    override init(){
        super.init()
        
        //load in emotions
        emotionsArray.append(anger)
        emotionsArray.append(disgust)
        emotionsArray.append(fear)
        emotionsArray.append(joy)
        emotionsArray.append(sadness)
    }
    
    func getSelectedEmotion() -> String {
        return emotionsArray[index].Name
    }
    
    func getEmotionAt(increment:Int) -> String {
        return emotionsArray[(index+increment)%emotionsArray.count].Name
    }
    
    func getBrightColour() -> UIColor {
        return emotionsArray[index].BrightColour
    }
    
    func getDarkColour() -> UIColor {
        return emotionsArray[index].DarkColour
    }
    
    func getTextColour() -> UIColor {
        return emotionsArray[index].TextColour
    }
    
    func incrementIndex(){
        index++
        if index >= emotionsArray.count {
            index = 0
        }
    }
    
    func decrementIndex(){
        index--
        if index <= -1 {
            index = emotionsArray.count - 1
        }
    }
    
    // This code snippit was taken from http://jamesonquave.com/blog/making-a-post-request-in-swift/
    // In order to allow the Feelz object to post it's data to an API using JSON
    // The work I've done here is to make it modern for Swift 2.0
    
    func post(params : Dictionary<String, String>, url : String) {
        
        do{
            guard let actualURL = NSURL(string: url) else { return }
            let request = NSMutableURLRequest(URL: actualURL)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                
                guard let actualData = data else { return }
                print("Response: \(response)")
                let strData = NSString(data: actualData, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(actualData, options: .MutableLeaves) as? NSDictionary
                    
                    if let parseJSON = json {
                        let success = parseJSON["success"] as? Int
                        print("Succes: \(success)")
                    }
                    else {
                        print("Error could not parse JSON, maybe server isn't running")
                    }
                } catch  {
                    print("Error could not parse JSON")
                }
            })
        
            task.resume()
            
        } catch {
            print("Error could not parse JSON")
        }
        
    }
}