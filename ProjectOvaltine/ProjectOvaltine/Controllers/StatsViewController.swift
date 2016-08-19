//
//  DetailViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SwiftSpinner

class StatsViewController: UITableViewController {
    let store = DataStore.sharedInstance
    var detailsArray = ["Economic","Education","Transit", "Demographic"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.tableView.tableHeaderView = ResultView.init(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 335));
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! ResultView
        headerView.scrollViewDidScroll(scrollView)
    }
 
    func statsTableView() {
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.sendSubviewToBack(tableView)
        tableView.frame.origin.y += 366
        
    }
    
   override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return 2
        return 1
    }
    
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let points = self.store.scoreData?.getScoresDictionary()
        
        
        if let key = points![detailsArray[indexPath.row]] {
            let cell = SearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier",parameterDescription: detailsArray[indexPath.row], description: "Description", score:key)
            return cell
        }
        
        let cell = SearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier",parameterDescription: detailsArray[indexPath.row], description: "Description", score:"90")
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(detailsArray[indexPath.row])
    }
    
    
    func navBar() {
        let statsNavBar = NavBar().setup()
        self.view.addSubview(statsNavBar)
        
        let navItem = UINavigationItem(title: "Stats")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor.blueColor()
        
        navItem.leftBarButtonItem = homeItem
        statsNavBar.setItems([navItem], animated: false)
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "menu-2"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 33, 33)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navItem.rightBarButtonItem = barButton
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingButtonPushed() {
        print("Settings Pushed")
    }
}
