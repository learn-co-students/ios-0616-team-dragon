//
//  PrototypeTabBar.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit


class PrototypeTabBar: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Project Ovaltine");
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem;
        
        //let settingsItem = UIBarButtonItem.init(title: "Settings", style: .Done, target: nil, action: #selector(settingButtonPushed));
        
        //navItem.rightBarButtonItem = settingsItem
        
        navBar.setItems([navItem], animated: false);
        
        let button: UIButton = UIButton(type: .Custom)
        
        //set image for button
        button.setImage(UIImage(named: "setting.png"), forState: UIControlState.Normal)
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
