//
//  DetailViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit

class DetailViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.initTabBarController()
    }
    
    func initTabBarController() {
        let tabViewController1 = TabViewController1()
        let tabViewController2 = TabViewController2()
        let tabViewController3 = TabViewController3()
        let tabViewController4 = TabViewController4()
        let tabViewController5 = TabViewController5()
        
        let item1 = tabViewController1
        let item2 = tabViewController2
        let item3 = tabViewController3
        let item4 = tabViewController4
        let item5 = tabViewController5
        
        let icon1 = UITabBarItem(title: "First", image: nil, tag: 0)
        let icon2 = UITabBarItem(title: "Second", image: nil, tag: 1)
        let icon3 = UITabBarItem(title: "Third", image: nil, tag: 2)
        let icon4 = UITabBarItem(title: "Fourth", image: nil, tag: 3)
        let icon5 = UITabBarItem(title: "Fifth", image: nil, tag: 4)
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        item4.tabBarItem = icon4
        item5.tabBarItem = icon5
        
        let controllers = [item1, item2, item3, item4, item5]
        self.viewControllers = controllers
        
    }
}