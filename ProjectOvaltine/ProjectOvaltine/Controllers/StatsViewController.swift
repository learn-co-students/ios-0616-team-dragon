//
//  DetailViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SwiftSpinner

class StatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var detailsArray = ["Finance","Education","Transportation", "Demographics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.statsTableView()
        self.ratingTextView()
        self.navBar()
    }
    
    func ratingTextView() {
        let ratingsView = ResultView()
        self.view.addSubview(ratingsView!)
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
        return 66
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return 2
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier",parameterDescription: detailsArray[indexPath.row], description: "Description", score:"90")
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if self.detailsArray[indexPath.row] == "Finance" {
//            let destinationVC = FinanceDataViewController()
//            self.navigationController?.pushViewController(destinationVC, animated: true)
//        }  else if self.detailsArray[indexPath.row] == "Education" {
//            let destinationVC = EducationDataViewController()
//            self.navigationController?.pushViewController(destinationVC, animated: true)
//        } else if self.detailsArray[indexPath.row] == "Transportation" {
//            let destinationVC = DetailViewController()
//            self.navigationController?.pushViewController(destinationVC, animated: true)
//        } else if self.detailsArray[indexPath.row] == "Demographics" {
//            let destinationVC = DemographicDataViewController()
//            self.navigationController?.pushViewController(destinationVC, animated: true)
//        }
        print(detailsArray[indexPath.row])
    }

    
    func navBar() {
        let statsNavBar = NavBar().setup()
        self.view.addSubview(statsNavBar)
        
        let navItem = UINavigationItem(title: "Stats")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor.blackColor()
        
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
