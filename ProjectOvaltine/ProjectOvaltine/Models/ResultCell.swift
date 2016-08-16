//
//  ResultCell.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    var locationNameLabel: UILabel! = UILabel()
    var resultGraph: UIImageView! = UIImageView()
    var locationScoreLabel: UILabel! = UILabel()
    var resultCatagoryLabel: UILabel! = UILabel()
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.locationNameLabel.text = "Test"
        self.resultGraph = UIImageView()
        self.locationScoreLabel.text = "Score"
        self.resultCatagoryLabel.text = "Category"
        
        contentView.addSubview(self.locationNameLabel)
        contentView.addSubview(self.resultGraph)
        contentView.addSubview(self.locationScoreLabel)
        contentView.addSubview(self.resultCatagoryLabel)
        contentView.addSubview(createScoreLabel())
    }
    
    func createScoreLabel() -> UILabel {
        self.locationScoreLabel.frame = CGRectMake(50, 50, 200, 30)
        self.locationScoreLabel.backgroundColor = UIColor.brownColor()
        self.locationScoreLabel.textColor = UIColor.whiteColor()
        self.locationScoreLabel.textAlignment = NSTextAlignment.Left
        self.locationScoreLabel.text = "My First Label"
        return self.locationScoreLabel
    }
}