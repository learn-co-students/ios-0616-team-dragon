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
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Project Ovaltine");
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem;
        
        navBar.setItems([navItem], animated: false);
        
        let button: UIButton = UIButton(type: .Custom)
        
        
        button.setImage(UIImage(named: "setting.png"), forState: UIControlState.Normal)
        
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
        
        navItem.rightBarButtonItem = barButton
        
    }

    
    func dismissView() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingButtonPushed() {
        
        
    }
    
    
}