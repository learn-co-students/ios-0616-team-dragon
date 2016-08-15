//
//  NavBar.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class NavBar {
    let width: CGFloat = UIScreen.mainScreen().bounds.width
    
    func setup() -> UINavigationBar {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width:self.width, height: 50))
        //let navItem = UINavigationItem(title: "Statistics")
        //let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        //navItem.leftBarButtonItem = homeItem
        //navBar.setItems([navItem], animated: false)
        navBar.alpha = 1.0
        navBar.layer.zPosition = 3
        //let button: UIButton = UIButton(type: .Custom)
        //button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        //button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        //button.frame = CGRectMake(3, 3, 33, 33)
        
        //let barButton = UIBarButtonItem(customView: button)
        //self.navigationItem.rightBarButtonItem = barButton
       // navItem.rightBarButtonItem = barButton
        navBar.barTintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name:"AppleSDGothicNeo-Regular", size: 34)!,  NSForegroundColorAttributeName: UIColor.blackColor()]
        return navBar
    }
}