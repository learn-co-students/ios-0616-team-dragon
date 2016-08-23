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
        self.currentLabel.textColor = UIColor.blackColor()
        self.currentLabel.font = HelveticaLight().getFont(20)
        return self.currentLabel
    }
    
    func addComparisonLabel() -> UILabel {
        self.comparisonLabel.layer.borderWidth = 3
        self.comparisonLabel.font = HelveticaLight().getFont(33)
        self.comparisonLabel.layer.masksToBounds = true
        self.comparisonLabel.layer.cornerRadius = 50
        self.comparisonLabel.textAlignment = NSTextAlignment.Center
        return self.comparisonLabel
    }
    
    func addRatingsLabel() -> UILabel {
        self.ratingLabel.layer.borderWidth = 3
        self.ratingLabel.font = HelveticaLight().getFont(33)
        self.ratingLabel.layer.masksToBounds = true
        self.ratingLabel.layer.cornerRadius = 50
        self.ratingLabel.textAlignment = NSTextAlignment.Center
        return self.ratingLabel
    }
    
    func addSearchedLabel() -> UILabel {
        self.searchedLabel.text = "New York City"
        self.searchedLabel.textColor = UIColor.blackColor()
        self.searchedLabel.font = HelveticaLight().getFont(20)
        return self.searchedLabel
    }
}

