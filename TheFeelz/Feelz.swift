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
        var title = String()
        var imageTitle = String()
        var backgroundColour = UIColor()
        var fontColour = UIColor()
        var linkColour = UIColor()
    }
    
    let anger = Emotion(title: "Angry", imageTitle: "Anger", backgroundColour: UIColorFromRGB("F40009"), fontColour: UIColorFromRGB("480002"), linkColour: UIColorFromRGB("FCF0E6"))
    
    let disgust = Emotion(title: "Disgust", imageTitle: "Disgust", backgroundColour: UIColorFromRGB("70B451"), fontColour: UIColorFromRGB("0F2D07"), linkColour: UIColorFromRGB("23F307"))
    
    let fear = Emotion(title: "Fear", imageTitle: "Fear", backgroundColour: UIColorFromRGB("C472FC"), fontColour: UIColorFromRGB("20023E"), linkColour: UIColorFromRGB("DCBADC"))
    
    let joy = Emotion(title: "Happy", imageTitle: "Joy", backgroundColour: UIColorFromRGB("F6DC49"), fontColour: UIColorFromRGB("0F70F2"), linkColour: UIColorFromRGB("D9890E"))
    
    let sadness = Emotion(title: "Sad", imageTitle: "Sadness", backgroundColour: UIColorFromRGB("49C2F7"), fontColour: UIColorFromRGB("0A2363"), linkColour: UIColorFromRGB("B7D1E0"))
    
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
        return emotionsArray[index].title
    }
    
    func getEmotionWith(increment:Int) -> String {
        return emotionsArray[(index+increment)%emotionsArray.count].title
    }
    
    func getEmotionImageTitleWith(increment:Int) -> String {
        return emotionsArray[(index+increment)%emotionsArray.count].imageTitle
    }
    
    func getSelectedEmotionImageTitle() -> String {
        return emotionsArray[index].imageTitle
    }
    
    func getEmotionImageTitleAt(index:Int) -> String {
        return emotionsArray[index].imageTitle
    }
    
    func getBackgroundColour() -> UIColor {
        return emotionsArray[index].backgroundColour
    }
    
    func getFontColour() -> UIColor {
        return emotionsArray[index].fontColour
    }
    
    func getLinkColour() -> UIColor {
        return emotionsArray[index].linkColour
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