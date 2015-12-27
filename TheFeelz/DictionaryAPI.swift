//
//  DictionaryAPI.swift
//  DictionaryAPI
//
//  Created by FareedQ on 2015-12-13.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import UIKit

class DictionaryAPI: NSObject, NSXMLParserDelegate {
    
    let apiURL = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/"
    let apiKey = "0c6d0974-cb20-41a7-a023-e7fbd4e4c1e8"
    let maxNumberOfResponse = 3
    
    var globaleParser = NSXMLParser()
    var globalResponseString = String()
    var responseCounter = 1
    var responseStringBuilder = String()
    var shouldRecord = false
    
    func execute(wordToSearch:String) -> String {
        guard let actualURL = NSURL(string: apiURL + wordToSearch + "&key=" + apiKey) else {return ""}
        guard let parser = NSXMLParser(contentsOfURL:actualURL) else {return ""}
        globaleParser = parser
        globaleParser.delegate = self
        globaleParser.parse()
        return globalResponseString
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "dt" {
            shouldRecord = true
        }
        if elementName == "sx" || elementName == "vi" {
            shouldRecord = false
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "dt" {
            shouldRecord = false
            addToResponse()
        }
        if elementName == "sx" || elementName == "vi" {
            shouldRecord = true
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if shouldRecord {
            responseStringBuilder += string
        }
    }
    
    func addToResponse(){
        responseStringBuilder = responseStringBuilder.stringByReplacingOccurrencesOfString(":", withString: "")
        if responseStringBuilder != "" {
            responseStringBuilder = "\(responseCounter). " + responseStringBuilder + "\n"
            globalResponseString += responseStringBuilder
            responseStringBuilder = ""
            responseCounter++
            if responseCounter > maxNumberOfResponse {
                globaleParser.abortParsing()
            }
        }
    }
    
}
