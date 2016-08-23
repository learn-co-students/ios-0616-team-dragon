//
//  Extensions.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import CoreGraphics

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

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        //let context = UIGraphicsGetCurrentContext() as CGContextRef
        //error: 'CGContext?' is not convertible to 'CGContextRef'
        //CGContextRef == CGContext, so it's saying "'CGContext?' is not convertible to 'CGContext'"
        //->you just need to unwrap it
        let context = UIGraphicsGetCurrentContext()!
        
        
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        //CGContextSetBlendMode(context, kCGBlendModeNormal)
        //error: use of unresolved identifier 'kCGBlendModeNormal'
        //->See the CGBlendMode constants in the CGContext Reference, it's got enum.
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage  
    }  
}

protocol Navigable {
    //implemented in extension
}

extension Navigable {
//    func setupNavBar() -> UINavigationBar {
//        let appFonty = AppFont()
//        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
//        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 70))
//        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:appFonty.appFontName, size:appFonty.appFontSize)!, NSForegroundColorAttributeName: UIColor.blueColor()]
//        let navigationItem = UINavigationItem(title: "Project Ovaltine")
//        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: nil)
//        navigationItem.leftBarButtonItem = homeItem
//        navigationBar.setItems([navigationItem], animated: false)
//        
//        let button: UIButton = UIButton(type: .Custom)
//        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
//        button.frame = CGRectMake(3, 3, 25, 25)
//        
//        let barButton = UIBarButtonItem(customView: button)
//        navigationItem.rightBarButtonItem = barButton
//        navigationBar.setItems([navigationItem], animated: false)
//        
//        return navigationBar
//    }
}
