//
//  Tabable.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol Tabable: UITabBarControllerDelegate {
    //implemented in extension
}

extension Tabable {
    var tabViewController1 : TabViewController1 { return TabViewController1() }
    var tabViewController2 : TabViewController2 { return TabViewController2() }
    var tabViewController3 : TabViewController3 { return TabViewController3() }
    var tabViewController4 : TabViewController4 { return TabViewController4() }
    var tabViewController5 : TabViewController5 { return TabViewController5() }
    
    var icon1 : UITabBarItem { return UITabBarItem(title: "Statistics", image: UIImage(named: "rating.png"), tag: 0) }
    var icon2 : UITabBarItem { return UITabBarItem(title: "Finance", image: UIImage(named: "emp.png"), tag: 1) }
    var icon3 : UITabBarItem { return UITabBarItem(title: "Education", image: UIImage(named: "edu.png"), tag: 2) }
    var icon4 : UITabBarItem { return UITabBarItem(title: "Transportation", image: UIImage(named: "trans.png"), tag: 3) }
    var icon5: UITabBarItem { return UITabBarItem(title: "Demographics", image: UIImage(named: "resource.png"), tag: 4) }
    
    func setupTabBar() -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.delegate = self

        let item1 = self.tabViewController1
        let item2 = self.tabViewController2
        let item3 = self.tabViewController3
        let item4 = self.tabViewController4
        let item5 = self.tabViewController5
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        item4.tabBarItem = icon4
        item5.tabBarItem = icon5
        
        let controllers = [item1, item2, item3, item4, item5]
        tabBarVC.viewControllers = controllers
        return tabBarVC
    }
}