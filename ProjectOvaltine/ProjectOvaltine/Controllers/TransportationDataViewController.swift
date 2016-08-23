//
//  ResultTableViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import MapKit
import SwiftSpinner
import SnapKit

class TransportationDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["Commute Time","Public Transportation","etc."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex:0xFFFFFF)
        self.navBar()
        self.resultsTableView()
        self.ratingTextView()
        self.comparisonTextView()
        self.currentLocationLabel()
        self.searchedLocationLabel()
    }
    
    func currentLocationLabel() {
        
        let currentLabel = UILabel()
        
        self.view.addSubview(currentLabel)
        
        currentLabel.text = "Bergen County"
        
        currentLabel.textColor = UIColor.blackColor()
        currentLabel.font = UIFont(name:"Univers Ultra Condensed", size:20)
        currentLabel.sendSubviewToBack(currentLabel)
        currentLabel.layer.masksToBounds = true
        currentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(15)
            make.top.equalTo(view).offset(66)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
    
    func searchedLocationLabel() {
        
        let searchedLabel = UILabel()
        
        self.view.addSubview(searchedLabel)
        
        searchedLabel.text = "New York City"
        
        searchedLabel.textColor = UIColor.blackColor()
        searchedLabel.font = UIFont(name:"Univers Ultra Condensed", size:20)
        searchedLabel.sendSubviewToBack(searchedLabel)
        searchedLabel.layer.masksToBounds = true
        searchedLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(view).offset(75)
            make.top.equalTo(view).offset(66)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
    
    func ratingTextView() {
        let ratingLabel = UILabel()
        self.view.addSubview(ratingLabel)
        ratingLabel.text = "9.5"
        ratingLabel.backgroundColor = UIColor(netHex:0x000000)
        ratingLabel.textColor = UIColor.greenColor()
        ratingLabel.layer.borderWidth = 3
        ratingLabel.layer.borderColor = UIColor.greenColor().CGColor
        ratingLabel.font = UIFont(name:"Futura", size:33)
        ratingLabel.sendSubviewToBack(ratingLabel)
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 50
        ratingLabel.textAlignment = NSTextAlignment.Center
        ratingLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(110)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    func comparisonTextView() {
        
        let comparisonLabel = ComparisonLabel().addComparisonLabel()
        self.view.addSubview(comparisonLabel)
        comparisonLabel.text = "9.5"
        
        comparisonLabel.sendSubviewToBack(comparisonLabel)
        comparisonLabel.textAlignment = NSTextAlignment.Center
        comparisonLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(110)
            make.width.equalTo(100)
            make.height.equalTo(100)
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
        return self.myArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        cell.myLabel1.text = myArray[indexPath.row]
        //cell.myLabel2.text = "\(indexPath.row + 1)"
        cell.myButton1.addTarget(self, action: #selector(TransportationDataViewController.pressedButton1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.myButton2.addTarget(self, action: #selector(TransportationDataViewController.pressedButton2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        if(indexPath.row % 2 == 0) {
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
        
        print(self.myArray[indexPath.row])
    }
    
    func navBar() {
        
        let transportNavBar = NavBar().setup()
        
        self.view.addSubview(transportNavBar)
        
        transportNavBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(20)
            make.width.equalTo(view)
        }
        
        transportNavBar.barTintColor = UIColor(netHex:0x00C963)
        let navItem = UINavigationItem(title: "Transportation")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor(netHex:0x000000)
        
        navItem.leftBarButtonItem = homeItem
        transportNavBar.setItems([navItem], animated: false)
        transportNavBar.alpha = 0.6
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
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