//
//  DetailViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SwiftSpinner

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var detailsArray = ["Finance","Education","Transportation", "Demographics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        navBar()
        statsTableView()
        ratingTextView()
    }
    
    func ratingTextView() {
        
        let text1 = "9.5"
        
        let label = UILabel(frame : CGRect(x:60, y:90, width:90, height:100))
        view.addSubview(label)
        
        label.backgroundColor = UIColor.blueColor()
        label.text = text1
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name:"AppleSDGothicNeo-Light", size:66)
        label.sendSubviewToBack(label)
    }
    
    func statsTableView() {
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.sendSubviewToBack(tableView)
        tableView.frame.origin.y += 366
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        if indexPath.section == 0 && indexPath.row == 0 {
        //
        //            return 333
        //        }
        return 66
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return 2
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if section == 0 {
        //            return 1
        //        }
        
        return detailsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier",locationName: "New York City", description:"Description", score:"90")
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(detailsArray[indexPath.row])
        
    }
    
    func navBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Statistics")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem
        
        navBar.setItems([navItem], animated: false)
        navBar.alpha = 1.0
        navBar.layer.zPosition = 3
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navItem.rightBarButtonItem = barButton
        navBar.barTintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name:"AppleSDGothicNeo-Regular", size: 34)!,  NSForegroundColorAttributeName: UIColor.blackColor()]
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
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        delegate = self
//        self.initTabBarController()
//        self.tabBar.tintColor = UIColor.blueColor()
//    }
//    
//    func initTabBarController() {
//        let tabViewController1 = TabViewController1()
//        let tabViewController2 = TabViewController2()
//        let tabViewController3 = TabViewController3()
//        let tabViewController4 = TabViewController4()
//        let tabViewController5 = TabViewController5()
//        
//        let item1 = tabViewController1
//        let item2 = tabViewController2
//        let item3 = tabViewController3
//        let item4 = tabViewController4
//        let item5 = tabViewController5
//        
//        let icon1 = UITabBarItem(title: "Statistics", image: UIImage(named: "futures.png"), tag: 0)
//        let icon2 = UITabBarItem(title: "Finance", image: UIImage(named: "money_bag.png"), tag: 1)
//        let icon3 = UITabBarItem(title: "Education", image: UIImage(named: "classroom.png"), tag: 2)
//        let icon4 = UITabBarItem(title: "Transportation", image: UIImage(named: "bus.png"), tag: 3)
//        let icon5 = UITabBarItem(title: "Demographics", image: UIImage(named: "conference.png"), tag: 4)
//        
//        item1.tabBarItem = icon1
//        item2.tabBarItem = icon2
//        item3.tabBarItem = icon3
//        item4.tabBarItem = icon4
//        item5.tabBarItem = icon5
//        
//        let controllers = [item1, item2, item3, item4, item5]
//        self.viewControllers = controllers
//
//    }
