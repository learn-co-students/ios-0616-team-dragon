//
//  TabViewController4.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit

class TabViewController4: UIViewController, Navigable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(self.setupNavBar())
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingButtonPushed() {
        //not implemented yet
    }
    
    
}
