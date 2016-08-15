//
//  Extensions.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

import UIKit

protocol Tabable: UITabBarControllerDelegate {
    //implemented in extension
}

extension Tabable {
    var statsViewController : StatsViewController { return StatsViewController() }
    var mapkitViewController : MapKitViewController { return MapKitViewController() }
    var demographicDataViewController : DemographicDataViewController { return DemographicDataViewController() }
    var financeDataViewController : FinanceDataViewController { return FinanceDataViewController() }
    var educationDataViewController : EducationDataViewController { return EducationDataViewController() }
    var transportationDataViewController : TransportationDataViewController { return TransportationDataViewController() }
    
    var statisticIcon : UITabBarItem { return UITabBarItem(title: "Statistics", image: UIImage(named: "rating.png"), tag: 0) }
    var economicIcon : UITabBarItem { return UITabBarItem(title: "Finance", image: UIImage(named: "emp.png"), tag: 1) }
    var educationIcon : UITabBarItem { return UITabBarItem(title: "Education", image: UIImage(named: "edu.png"), tag: 2) }
    var transportationIcon : UITabBarItem { return UITabBarItem(title: "Transportation", image: UIImage(named: "trans.png"), tag: 3) }
    var demographicIcon: UITabBarItem { return UITabBarItem(title: "Demographics", image: UIImage(named: "resource.png"), tag: 4) }
    
    func setupTabBar() -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.delegate = self
        
        let mapItem = self.mapkitViewController
        let resultItem = self.statsViewController
        let demographicItem = self.demographicDataViewController
        let economicItem = self.financeDataViewController
        let educationItem = self.educationDataViewController
        
        mapItem.tabBarItem = statisticIcon
        resultItem.tabBarItem = statisticIcon
        demographicItem.tabBarItem = educationIcon
        economicItem.tabBarItem = economicIcon
        educationItem.tabBarItem = educationIcon
        
        let controllers = [mapItem, resultItem, demographicItem, economicItem, educationItem]
        tabBarVC.viewControllers = controllers
        return tabBarVC
    }
}


protocol Navigable {
    //implemented in extension
}

extension Navigable {
    func setupNavBar() -> UINavigationBar {
        let appFonty = AppFont()
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 70))
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:appFonty.appFontName, size:appFonty.appFontSize)!, NSForegroundColorAttributeName: UIColor.blueColor()]
        let navigationItem = UINavigationItem(title: "Project Ovaltine")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: nil)
        navigationItem.leftBarButtonItem = homeItem
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }
}
