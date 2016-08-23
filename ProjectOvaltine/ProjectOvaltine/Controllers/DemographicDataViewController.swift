//
//  DemographicDataViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SnapKit

class DemographicDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["Diversity","Population","etc."]
    
    let comparisonLabel = ComparisonLabel().addComparisonLabel()
    let currentLabel = ComparisonLabel().addCurrentLabel()
    let ratingLabel = ComparisonLabel().addRatingsLabel()
    let searchedLabel = ComparisonLabel().addSearchedLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex:0xFFFFFF)
        self.navBar()
        self.setupLabels()
        self.setupConstraints()
    }
    
    func setupLabels() {
        self.view.addSubview(self.currentLabel)
        self.currentLabel.text = "Bergen County"
        self.currentLabel.sendSubviewToBack(self.currentLabel)
        self.currentLabel.layer.masksToBounds = true
        
        self.searchedLabel.text = "New York City"
        self.view.addSubview(self.searchedLabel)
        self.searchedLabel.sendSubviewToBack(self.searchedLabel)
        self.searchedLabel.layer.masksToBounds = true
        
        self.view.addSubview(self.ratingLabel)
        self.ratingLabel.text = "9.5"
        self.ratingLabel.sendSubviewToBack(self.ratingLabel)
        
        self.view.addSubview(self.comparisonLabel)
        self.comparisonLabel.text = "9.5"
        self.comparisonLabel.sendSubviewToBack(self.comparisonLabel)
        self.comparisonLabel.textAlignment = NSTextAlignment.Center
    }
    
    func setupConstraints() {
        self.comparisonLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(110)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        self.currentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(15)
            make.top.equalTo(view).offset(66)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        self.ratingLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(110)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        self.searchedLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.view).offset(75)
            make.top.equalTo(self.view).offset(66)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }

    
    func resultsTableView() {
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.frame.origin.y += 190
        tableView.backgroundColor = UIColor(netHex:0xFFFFFF)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        cell.myLabel1.text = myArray[indexPath.row]
        
        cell.myButton1.addTarget(self, action: #selector(DemographicDataViewController.pressedButton1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.myButton2.addTarget(self, action: #selector(DemographicDataViewController.pressedButton2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.clearColor()//(netHex:0xFFFFFF)
        } else {
            cell.backgroundColor = UIColor.clearColor()//(netHex:0xFFFFFF)
        }
        
        return cell
    }
    
    func pressedButton1(sender: UIButton) {
        print("Pressed Button 1")
    }
    
    func pressedButton2(sender: UIButton) {
        print("Pressed Button 2")
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(myArray[indexPath.row])
    }
    
    func navBar() {
        let demographicNavBar = NavBar().setup()
        self.view.addSubview(demographicNavBar)
        
        demographicNavBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(20)
            make.width.equalTo(view)
        }
        
        
        let navItem = UINavigationItem(title: "Demographics")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem
        demographicNavBar.setItems([navItem], animated: false)
        demographicNavBar.alpha = 0.6
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "menu-2"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 25, 25)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navItem.rightBarButtonItem = barButton
    }
    
    func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingButtonPushed() {
        print("Settings Pushed")
    }
}