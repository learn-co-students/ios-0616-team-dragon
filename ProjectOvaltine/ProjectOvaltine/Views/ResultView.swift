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
    private var gaugeView: GaugeView!
    
    var graph: UIView?
    var score: UIView!
    var locationName: UILabel?
    var graphDescription = UILabel()
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
        self.gaugeView = GaugeView(frame: CGRect(x:self.view.frame.width/1.8, y:self.view.frame.height * 1.5, width: 200, height: 200))
        self.gaugeView.percentage = 80
        self.gaugeView.thickness = 9
        self.gaugeView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        self.gaugeView.labelColor = UIColor.blueColor()
        self.gaugeView.gaugeBackgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.gaugeView)
        self.view.addSubview(self.createScoreLabel().0)
        self.view.addSubview(self.createScoreLabel().1)
        self.view.addSubview(self.createScoreLabel().2)
    }
    
    func createScoreLabel() -> (UILabel, UILabel, UILabel){
        
        //let appyFont = AppFont()
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
        self.graphDescription.frame = CGRect(x: 10, y: self.view.frame.height * 0.8, width: 300, height:600)
        self.graphDescription.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        self.graphDescription.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
        self.graphDescription.textColor = UIColor.blackColor()
        
        
        self.locationName = UILabel()
        self.locationName!.text = "TEST"
        return((self.resultLocationNameLabel, self.resultParameter, self.graphDescription))
    }

    var result: ResultModel! {
        didSet {
            self.resultLocationNameLabel.text = result.resultLocationName
        }
    }
}
