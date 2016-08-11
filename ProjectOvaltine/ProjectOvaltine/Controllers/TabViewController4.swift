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
//    func navBar() {
//        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
//        self.view.addSubview(navBar)
//        let navItem = UINavigationItem(title: "Transportation")
//        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
//        
//        navItem.leftBarButtonItem = homeItem
//        
//        navBar.setItems([navItem], animated: false)
//        navBar.alpha = 1.0
//        
//        let button: UIButton = UIButton(type: .Custom)
//        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
//        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
//        button.frame = CGRectMake(3, 3, 33, 33)
//        
//        let barButton = UIBarButtonItem(customView: button)
//        self.navigationItem.rightBarButtonItem = barButton
//        navItem.rightBarButtonItem = barButton
//    }
    
    
}
