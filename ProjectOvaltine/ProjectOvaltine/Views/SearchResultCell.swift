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
        self.createGraph()
        self.createLabels()
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.resultLocationNameLabel)
        self.contentView.addSubview(self.graphView)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createGraph()
        self.createLabels()
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.resultLocationNameLabel)
        self.contentView.addSubview(self.graphView)
        self.setupView()
    }
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, parameterDescription: String, description:String, score:String) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.scoreLabel.text = score
        self.resultDescription.text = description
        self.resultLocationNameLabel.text = parameterDescription
        self.createGraph()
        self.createLabels()
        self.contentView.clipsToBounds = true
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.resultLocationNameLabel)
        self.contentView.addSubview(self.graphView)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.scoreLabel.sizeThatFits(CGSize(width: 20, height: 35))
        //self.scoreLabel.backgroundColor = UIColor.orangeColor()
        //self.scoreLabel.frame = CGRect(x: 20, y: 15, width: 80, height: 35)
        self.resultLocationNameLabel.sizeThatFits(CGSize(width: 80, height: 35))
       // self.resultLocationNameLabel.backgroundColor = UIColor.purpleColor()
        //self.resultLocationNameLabel.frame = CGRect(x: 180, y: 15, width:180, height: 30)
    }
    
    
    func createGraph() {
        //var newGraph = GaugeView()
//        self.graphView = GaugeView(frame: CGRect(x:self.contentView.frame.width/1.8, y:10, width: self.contentView.frame.width, height:self.contentView.frame.height))
        self.graphView = GaugeView()
        //self.graphView.sizeThatFits(CGSize(width: self.contentView.frame.width/1.8, height: self.contentView.frame.width))
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
    
    func setupView() {
        self.scoreLabel.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(60)
            
        }
        
        self.resultLocationNameLabel.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(100)
            make.center.equalTo(self.contentView)
        }
//        self.resultDescription.snp_makeConstraints { (make) -> Void in
////            make.size.equalTo(100)
////            make.center.equalTo(self)
//        }
        //
            self.graphView.snp_makeConstraints { (make) -> Void in
                make.size.equalTo(40)
                make.right.equalTo(self.contentView)
                //make.trailing.equalTo(self)
            }
    }
    
}