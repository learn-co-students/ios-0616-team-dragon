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
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.magentaColor()
        
        navBar()
        
        //ratingLabel()
        
        graphImage()
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        
//        SwiftSpinner.showWithDuration(1.9, title: "TEAM DRAGON")
//        
//        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
//    }
    
//    func ratingLabel() {
//        
//        let ratings = UIButton(frame: CGRectMake(20, 80, self.view.frame.width-40, 40))
//        ratings.backgroundColor = UIColor.whiteColor()
//        ratings.setTitle("RATING", forState: .Normal)
//        ratings.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        ratings.alpha=0.6
//        ratings.layer.borderWidth=0.3
//        ratings.layer.cornerRadius=2
//        self.view.addSubview(ratings)
//    }
    
    func graphImage() {
        //********** creating UIImageView Programmatically******//
        
        let imageView = UIImageView(frame: CGRectMake(20, 175, 375, 400))
        let image = UIImage(named: "barGraph.png")
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
    func navBar() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Ratings")
        
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem
        
        //let settingsItem = UIBarButtonItem.init(title: "Settings", style: .Done, target: nil, action: #selector(settingButtonPushed));
        
        //navItem.rightBarButtonItem = settingsItem
        
        navBar.setItems([navItem], animated: false)
        
        let button: UIButton = UIButton(type: .Custom)
        
        //set image for button
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        //add function for button
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        navItem.rightBarButtonItem = barButton
        
    }
    
    func dismissView() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingButtonPushed() {
        
        
    }
}
