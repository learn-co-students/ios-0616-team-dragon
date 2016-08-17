//
//  SearchResultCell.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import SnapKit
import GaugeView

class SearchResultCell: UITableViewCell {
    private var graphView: GaugeView!
    var scoreLabel:UILabel! = UILabel()
    var resultLocationNameLabel:UILabel! = UILabel()
    var resultDescription: UITextView! = UITextView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, parameterDescription: String, description:String, score:String) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.scoreLabel.text = score
        self.resultDescription.text = description
        self.resultLocationNameLabel.text = parameterDescription
        self.createGraph()
        self.createLabels()
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.resultLocationNameLabel)
        self.contentView.addSubview(self.graphView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.scoreLabel.frame = CGRect(x: 20, y: 15, width: 80, height: 35)
        self.resultLocationNameLabel.frame = CGRect(x: 140, y: 15, width: 200, height: 30)
    }
    
    
    func createGraph() {
        self.graphView = GaugeView(frame: CGRect(x:self.contentView.frame.width, y:10, width: self.contentView.frame.height, height:self.contentView.frame.height))
        self.graphView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
    }
    
    func createLabels() {
        self.resultLocationNameLabel.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
        self.scoreLabel.textColor = UIColor.whiteColor()
        self.scoreLabel.font = UIFont(name:"AppleSDGothicNeo", size:16)
        self.scoreLabel.textAlignment = NSTextAlignment.Center
        self.scoreLabel.backgroundColor = UIColor.grayColor()
        self.scoreLabel.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        //        self.scoreLabel.layer.cornerRadius = (20/2)
        self.scoreLabel.layer.borderWidth = 1.0
        
    }
}