//
//  ResultView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import SnapKit


class ResultView: UIView {
    var graph: UIView?
    var score: UIView!
    var locationName: UILabel?
    var graphDescription: UILabel?
    var resultParameter: String?
    var view: UIView!
    var resultLocationNameLabel = UILabel()
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
        self.view = UIView()
        self.view.frame = CGRectMake(300, 200, 200, 30)
        self.view.backgroundColor = UIColor.grayColor()
        createScoreLabel()
    }
    
    func createScoreLabel() {
        self.resultLocationNameLabel.frame = CGRectMake(50, 50, 200, 30)
        self.resultLocationNameLabel.backgroundColor = UIColor.whiteColor()
        self.resultLocationNameLabel.textColor = UIColor.whiteColor()
        self.resultLocationNameLabel.textAlignment = NSTextAlignment.Left
        self.resultLocationNameLabel.text = "My First Label"
        self.view.addSubview(self.resultLocationNameLabel)
        self.locationName = UILabel()
        self.locationName!.text = "TEST"
        self.addSubview(self.locationName!)
        self.addSubview(self.resultLocationNameLabel)
    }

    var result: ResultModel! {
        didSet {
            self.resultLocationNameLabel.text = result.resultLocationName
        }
    }
}
