//
//  SettingsView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/17/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    let settingsLabel: UILabel! = UILabel()
    let settingsItem: UIButton! = UIButton()
    let height: CGFloat = UIScreen.mainScreen().bounds.height
    let width: CGFloat = UIScreen.mainScreen().bounds.width
    
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
        self.frame = CGRectMake(0, 0, width, height)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func setupLabels() {
        self.settingsLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
        self.settingsLabel.text = "Settings"
    }
}


