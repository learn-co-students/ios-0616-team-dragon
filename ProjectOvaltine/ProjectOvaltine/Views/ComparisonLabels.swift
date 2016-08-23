//
//  ComparisonLabels.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/22/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct ComparisonLabel {
    var comparisonLabel = UILabel()
    var ratingLabel = UILabel()
    var currentLabel = UILabel()
    var searchedLabel = UILabel()
    
    func addCurrentLabel() -> UILabel {
        return UILabel() 
    }
    
    func addComparisonLabel() -> UILabel {
        comparisonLabel.backgroundColor = UIColor(netHex:0x000000)
        comparisonLabel.textColor = UIColor.orangeColor()
        comparisonLabel.layer.borderWidth = 3
        comparisonLabel.layer.borderColor = UIColor.orangeColor().CGColor
        comparisonLabel.font = UIFont(name:"Helvetica-Light", size:33)
        comparisonLabel.layer.masksToBounds = true
        comparisonLabel.layer.cornerRadius = 50
        comparisonLabel.textAlignment = NSTextAlignment.Center
        return comparisonLabel
    }
    
    func addRatingsLabel() -> UILabel {
        ratingLabel.backgroundColor = UIColor(netHex:0x000000)
        ratingLabel.textColor = UIColor.orangeColor()
        ratingLabel.layer.borderWidth = 3
        ratingLabel.layer.borderColor = UIColor.orangeColor().CGColor
        ratingLabel.font = UIFont(name:"Helvetica-Light", size:33)
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 50
        ratingLabel.textAlignment = NSTextAlignment.Center
        return ratingLabel
    }
    
    func addSearchedLabel() -> UILabel {
        searchedLabel.text = "New York City"
        searchedLabel.textColor = UIColor.blackColor()
        searchedLabel.font = UIFont(name:"Helvetica-Light", size:20)
        return searchedLabel
    }
}

