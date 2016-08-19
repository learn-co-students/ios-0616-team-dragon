//
//  AppFont.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
struct ApplicationFont {
    //let applicationFontName = "HelveticaNeue-UltraLight"
    var fontType: String
    var fontSize: CGFloat
    //let appicaptionFontSize = CGFloat(20)
    
    mutating func getFontType(fontType:String) {
        self.fontType = fontType
    }
    
    mutating func forFontSize(fontSize:CGFloat) {
        self.fontSize = fontSize
    }
    
    mutating func font() -> UIFont {
        return UIFont(name: self.fontType, size: self.fontSize)!
    }
    
    
    
    
}