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
    
    var locationName: String?
    var view: UIView = UIView()
    var scoreLabel = UILabel()
    
    func createScoreLabel() {
        self.scoreLabel.frame = CGRectMake(50, 50, 200, 30)
        self.scoreLabel.backgroundColor = UIColor.brownColor()
        self.scoreLabel.textColor = UIColor.whiteColor()
        self.scoreLabel.textAlignment = NSTextAlignment.Left
        self.scoreLabel.text = "My First Label"
        self.view.addSubview(self.scoreLabel)
    }
    
    var result: ResultModel! {
        didSet {
            self.scoreLabel.text = String(result.scoreData.score)
        }
    }
}