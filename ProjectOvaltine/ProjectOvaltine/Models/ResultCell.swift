//
//  ResultCell.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    static let cellReuseIdentifier = "ResultCell"
    
    var resultParameter: String?
    var view: UIView = UIView()
    var parameterLabel = UILabel()
    
    
    func createScoreLabel() {
        self.parameterLabel.frame = CGRectMake(50, 50, 200, 30)
        self.parameterLabel.backgroundColor = UIColor.brownColor()
        self.parameterLabel.textColor = UIColor.whiteColor()
        self.parameterLabel.textAlignment = NSTextAlignment.Left
        self.parameterLabel.text = "My First Label"
        self.view.addSubview(self.parameterLabel)
    }
    
    var result: ResultModel! {
        didSet {
            self.parameterLabel.text = result.dataParameter
        }
    }
}