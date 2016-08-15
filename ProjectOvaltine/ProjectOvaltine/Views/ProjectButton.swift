//
//  ProjectButton.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/14/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct ProjectButton {
    var nameButton: UIButton!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    init() {
        self.nameButton = UIButton(frame: CGRectMake(20, 630, self.screenSize.width-40, 40))
        self.nameButton.backgroundColor=UIColor.lightGrayColor()
        self.nameButton.setTitle("PROJECT OVALTINE", forState: .Normal)
        self.nameButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.nameButton.alpha = 0.3
        self.nameButton.layer.zPosition = 3
        self.nameButton.layer.borderWidth = 0.3
        self.nameButton.layer.cornerRadius = 2
    }
    
    func setup() -> UIButton {
        return self.nameButton
    }
}
