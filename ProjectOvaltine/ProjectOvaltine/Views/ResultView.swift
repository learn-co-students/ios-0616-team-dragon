//
//  ResultView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import SnapKit
import GaugeView

class ResultView: UIView {
    private var graphView: GaugeView!
    
    var score: UIView!
    var locationName: UILabel?
    var graphDescriptionTextView = UITextView()
    var resultParameter: UILabel = UILabel()
    var view: UIView!
    var resultLocationNameLabel = UILabel()
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
        self.view = UIView()
        let width : CGFloat = 200.0
        let height : CGFloat = 200.0
        self.view.frame = CGRectMake(self.frame.size.width/2 - width/2
            , self.frame.size.height/2 - height/2, width, height)
        self.view.backgroundColor = UIColor.whiteColor()
        self.graphView = GaugeView(frame: CGRect(x:self.view.frame.width/1.8, y:self.view.frame.height * 1.5, width: 200, height: 200))
        self.graphView.percentage = 80
        self.graphView.thickness = 9
        self.graphView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        self.graphView.labelColor = UIColor.blueColor()
        self.graphView.gaugeBackgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.graphView)
        self.view.addSubview(self.createScoreLabel().0)
        self.view.addSubview(self.createScoreLabel().1)
        self.view.addSubview(self.createScoreLabel().2)
    }
    
    func createScoreLabel() -> (UILabel, UILabel, UITextView){
        self.resultLocationNameLabel.frame = CGRect(x: self.view.frame.width/1.3, y: self.view.frame.height * 1.2, width: 150, height: 40)
        self.resultLocationNameLabel.backgroundColor = UIColor.clearColor()
        self.resultLocationNameLabel.textColor = UIColor.blackColor()
        self.resultLocationNameLabel.textAlignment = NSTextAlignment.Left
        self.resultLocationNameLabel.font = UIFont(name:"AppleSDGothicNeo-Light", size:20)
        self.resultLocationNameLabel.text = "New York County"
        //self.view.addSubview(self.resultLocationNameLabel)
        
        self.resultParameter.frame = CGRect(x: self.view.frame.width/1.3, y: self.view.frame.height, width: 150, height: 40)
        
        self.resultParameter.text = "Financial Data"
        self.resultLocationNameLabel.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
        self.graphDescriptionTextView.frame = CGRect(x: 10, y: self.view.frame.height * 0.8, width: 300, height:600)
        self.graphDescriptionTextView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        self.graphDescriptionTextView.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
        self.graphDescriptionTextView.textColor = UIColor.blackColor()
        let fixedWidth = self.graphDescriptionTextView.frame.size.width
        self.graphDescriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = graphDescriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = graphDescriptionTextView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.graphDescriptionTextView.frame = newFrame
        self.locationName = UILabel()
        self.locationName!.text = "TEST"
        return((self.resultLocationNameLabel, self.resultParameter, self.graphDescriptionTextView))
    }

    var result: ResultModel! {
        didSet {
            self.resultLocationNameLabel.text = result.resultLocationName
        }
    }
}
