//
//  TabViewController1.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SwiftSpinner

class TabViewController1: UIViewController {
    
    override func viewDidLoad() {
<<<<<<< HEAD
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.magentaColor()
        navBar()
        graphImage()
    }
    
    func graphImage() {
        //********** creating UIImageView Programmatically******//
=======
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.magentaColor()
        
        navBar()
        
        graphImage()
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        
//        SwiftSpinner.showWithDuration(1.9, title: "TEAM DRAGON")
//        
//        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
//    }
    
    func graphImage() {
    
>>>>>>> 5d52fc58ebcad63d43d047c5cef0b7f77236fb34
        let imageView = UIImageView(frame: CGRectMake(20, 175, 375, 400))
        let image = UIImage(named: "barGraph.png")
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
    func navBar() {
<<<<<<< HEAD
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Statistics")
=======
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Ratings")
        
>>>>>>> 5d52fc58ebcad63d43d047c5cef0b7f77236fb34
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem
        
        navBar.setItems([navItem], animated: false)
<<<<<<< HEAD
        navBar.alpha = 1.0
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navItem.rightBarButtonItem = barButton
    }
    
    func dismissView() {
=======
        
        let button: UIButton = UIButton(type: .Custom)
        
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
        
        navItem.rightBarButtonItem = barButton
        
    }
    
    func dismissView() {
        
>>>>>>> 5d52fc58ebcad63d43d047c5cef0b7f77236fb34
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingButtonPushed() {
<<<<<<< HEAD
      //not implemented yet
=======
        
        
>>>>>>> 5d52fc58ebcad63d43d047c5cef0b7f77236fb34
    }
}
