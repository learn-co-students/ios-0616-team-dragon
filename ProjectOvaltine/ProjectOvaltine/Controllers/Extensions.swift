//
//  Extensions.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol Tabable: UITabBarControllerDelegate {
    //implemented in extension
}

extension Tabable {
    var resultViewController : ResultViewController { return ResultViewController() }
    var mapkitViewController : MapKitViewController { return MapKitViewController() }
    var demographicDataViewController : DemographicDataViewController { return DemographicDataViewController() }
    var economicDataViewController : EconomicDataViewController { return EconomicDataViewController() }
    var educationDataViewController : EducationDataViewController { return EducationDataViewController() }
    
    var icon1 : UITabBarItem { return UITabBarItem(title: "Statistics", image: UIImage(named: "rating.png"), tag: 0) }
    var icon2 : UITabBarItem { return UITabBarItem(title: "Finance", image: UIImage(named: "emp.png"), tag: 1) }
    var icon3 : UITabBarItem { return UITabBarItem(title: "Education", image: UIImage(named: "edu.png"), tag: 2) }
    var icon4 : UITabBarItem { return UITabBarItem(title: "Transportation", image: UIImage(named: "trans.png"), tag: 3) }
    var icon5: UITabBarItem { return UITabBarItem(title: "Demographics", image: UIImage(named: "resource.png"), tag: 4) }
    
    func setupTabBar() -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.delegate = self
        
        let item1 = self.mapkitViewController
        let item2 = self.resultViewController
        let item3 = self.demographicDataViewController
        let item4 = self.economicDataViewController
        let item5 = self.educationDataViewController
        
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
