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
    func addCurrentLabel() -> UILabel {
        return UILabel() 
    }
    
    func addComparisonLabel() -> UILabel {
        //comparisonLabel.text = "9.5"
        comparisonLabel.backgroundColor = UIColor(netHex:0x000000)
        comparisonLabel.textColor = UIColor.orangeColor()
        comparisonLabel.layer.borderWidth = 3
        comparisonLabel.layer.borderColor = UIColor.orangeColor().CGColor
        comparisonLabel.font = UIFont(name:"Futura", size:33)
        //comparisonLabel.sendSubviewToBack(comparisonLabel)
        comparisonLabel.layer.masksToBounds = true
        comparisonLabel.layer.cornerRadius = 50
        comparisonLabel.textAlignment = NSTextAlignment.Center
        return comparisonLabel
    }
}

