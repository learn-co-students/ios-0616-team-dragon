//
//  TabBarController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import SwiftSpinner

class TabBarController: UITabBarController, UITabBarControllerDelegate, Navigable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let statsTab: StatsViewController! = StatsViewController()
        let financeTab: FinanceDataViewController! = FinanceDataViewController()
        let educationTab: EducationDataViewController! = EducationDataViewController()
        let transportationTab: TransportationDataViewController! = TransportationDataViewController()
        let demographicsTab: DemographicDataViewController! = DemographicDataViewController()
        
        statsTab.tabBarItem.title = "Statistics"
        statsTab.tabBarItem.image = UIImage(named: "futures.png")
        financeTab.tabBarItem.title = "Finance"
        financeTab.tabBarItem.image = UIImage(named: "dollar-bill")
        educationTab.tabBarItem.title = "Education"
        educationTab.tabBarItem.image = UIImage(named: "classroom.png")
        transportationTab.tabBarItem.title = "Transportation"
        transportationTab.tabBarItem.image = UIImage(named: "bus.png")
        demographicsTab.tabBarItem.title = "Demographics"
        demographicsTab.tabBarItem.image = UIImage(named: "conference.png")
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(netHex:0xFFFFFF)], forState:.Selected)
        
        let controllers = [statsTab, financeTab, educationTab, transportationTab, demographicsTab]
        self.viewControllers = controllers
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.barTintColor = UIColor(netHex: 0x000000)
        
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("viewController selected: \(viewController.tabBarItem.title!)")
        return true
    }
    
    func dismissView() {
        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
        dismissViewControllerAnimated(true, completion: nil)
        SwiftSpinner.hide()
    }
    
    func settingButtonPushed() {
        print("Settings Pushed")
    }
}