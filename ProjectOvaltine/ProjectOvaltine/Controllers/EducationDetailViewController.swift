//
//  EducationDetailViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MapKit
import SwiftSpinner

class EducationDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view = UIView()
        self.view.frame = CGRectMake(300, 200, 200, 30)
        self.view.backgroundColor = UIColor.grayColor()
    }
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.showWithDuration(1.3, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
    }
    
}
