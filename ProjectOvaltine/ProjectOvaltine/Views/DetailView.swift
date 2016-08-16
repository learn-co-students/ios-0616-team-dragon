//
//  DetailView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import GaugeView
import SnapKit

class DetailView: UIView {
    var graphView:GaugeView!
    var topicLabel: UILabel! = UILabel()
    var scoreLabel: UILabel! = UILabel()
    var descriptionLabel: UILabel = UILabel()
    var sceenHeight = UIScreen.mainScreen().bounds.height
    var screenWidth = UIScreen.mainScreen().bounds.width
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder);
    }
    
    convenience init(topic: String, score: String, description: String) {
        self.init(frame: CGRectZero)
        self.topicLabel.text = topic
        self.scoreLabel.text = score
        self.descriptionLabel.text = description
    }
    
    func setupGraph() {
        self.graphView = GaugeView(frame: CGRect(x:0, y:0, width: 200, height: 200))
        self.graphView.percentage = 80
        self.graphView.thickness = 9
        self.graphView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        self.graphView.labelColor = UIColor.blueColor()
        self.graphView.gaugeBackgroundColor = UIColor.lightGrayColor()
        self.addSubview(graphView)
    }
    
    func setupLabels() {
        self.topicLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
        self.scoreLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
        self.descriptionLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
    }
    
    func setupConstraints() {
        
    }
}