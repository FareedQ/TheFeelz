//
//  HelperFunctions.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-28.
//  Copyright © 2015 FareedQ. All rights reserved.
//


//This file is used to store globally used helper funcitons through out the project. So that these function can be used anywhere.

import UIKit

func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor{
    let scanner = NSScanner(string:colorCode)
    var color:UInt32 = 0;
    scanner.scanHexInt(&color)
    
    let mask = 0x000000FF
    let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
    let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
    let b = CGFloat(Float(Int(color) & mask)/255.0)
    
    return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
}
