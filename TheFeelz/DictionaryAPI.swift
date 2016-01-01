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
    var definitionStringBuilder = String()
    var synonymStringBuilder = String()
    var shouldRecordDefinition = false
    var shouldRecordSynonyms = false
    var synonymArray = [String]()
    
    func execute(wordToSearch:String) -> String {
        
        checkIfWordIsPreloaded(wordToSearch)
        print(apiURL + wordToSearch + "&key=" + apiKey)
        guard let actualURL = NSURL(string: apiURL + wordToSearch + "&key=" + apiKey) else {return ""}
        guard let parser = NSXMLParser(contentsOfURL:actualURL) else {return ""}
        globaleParser = parser
        globaleParser.delegate = self
        globaleParser.parse()
        return globalResponseString
    }
    
    func checkIfWordIsPreloaded(wordToSearch:String){
        
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "dt" {
            shouldRecordDefinition = true
        }
        if elementName == "sx" {
            shouldRecordDefinition = false
            shouldRecordSynonyms = true
        }
        if elementName == "vi" {
            shouldRecordDefinition = false
        }
        if elementName == "sxn" {
            shouldRecordSynonyms = false
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "dt" {
            shouldRecordDefinition = false
            addToDefinition()
        }
        if elementName == "sx" {
            shouldRecordDefinition = true
            shouldRecordSynonyms = false
            addToSynonyms()
        }
        if elementName == "vi" {
            shouldRecordDefinition = true
        }
        if elementName == "sxn" {
            shouldRecordSynonyms = true
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if shouldRecordDefinition {
            definitionStringBuilder += string
        }
        if shouldRecordSynonyms {
            synonymStringBuilder += string
        }
    }
    
    func addToDefinition(){
        definitionStringBuilder = definitionStringBuilder.stringByReplacingOccurrencesOfString(":", withString: "")
        
        if definitionStringBuilder.stringByReplacingOccurrencesOfString(" ", withString: "") == "" {
            definitionStringBuilder = ""
            return
        }
        
        if definitionStringBuilder != "" {
            definitionStringBuilder = "\(responseCounter). " + definitionStringBuilder + "\n"
            globalResponseString += definitionStringBuilder
            definitionStringBuilder = ""
            responseCounter++
            if responseCounter > maxNumberOfResponse {
                globaleParser.abortParsing()
            }
        }
    }
    
    func addToSynonyms(){
        if synonymArray.count < 3 {
            synonymStringBuilder = synonymStringBuilder.stringByReplacingOccurrencesOfString(" ", withString: "")
            synonymArray.append(synonymStringBuilder)
        }
        synonymStringBuilder = ""
    }
    
}
