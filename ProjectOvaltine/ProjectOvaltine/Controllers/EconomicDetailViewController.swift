//
//  EconomicDetailViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MapKit
import SwiftSpinner

class EconomicDetailViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
    }
    
    func graphImage() {
        //********** creating UIImageView Programmatically******//
        let imageView = UIImageView(frame: CGRectMake(20, 175, 375, 400))
        let image = UIImage(named: "barGraph.png")
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.showWithDuration(1.3, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
