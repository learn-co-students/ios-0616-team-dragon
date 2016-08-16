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

class TransportationDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["Commute Time","Public Transportation","etc."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navBar()
        self.resultsTableView()
    }
    func resultsTableView() {
        
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame.origin.y += 55
        tableView.backgroundColor = UIColor(patternImage: UIImage(named:"commute.png")!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        let color = UIColor(netHex:0xDE4138)
        cell.myLabel1.text = myArray[indexPath.row]
        cell.myLabel1.font = UIFont(name:"Futura", size:25)
        cell.myLabel1?.layer.shadowColor = color.CGColor
        cell.myLabel1?.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        cell.myLabel1?.layer.shadowOpacity = 1.0
        cell.myLabel1?.layer.shadowRadius = 2.0
        
        //cell.myLabel2.text = "\(indexPath.row + 1)"
        cell.myButton1.addTarget(self, action: #selector(TransportationDataViewController.pressedButton1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        cell.myButton2.addTarget(self, action: #selector(TransportationDataViewController.pressedButton2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        let color = UIColor(netHex:0x6CD4E8)
        //        let color2 = UIColor(netHex:0x2DC5E8)
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor.clearColor()        }
        else
        {
            cell.backgroundColor = UIColor.clearColor()
        }
        
        return cell
    }
    
    func pressedButton1(sender: UIButton) {
        print("Pressed Button 1")
    }
    
    func pressedButton2(sender: UIButton) {
        print("Pressed Button 2")
    }
    
    
    func navBar() {
        
        let transportNavBar = NavBar().setup()
        self.view.addSubview(transportNavBar)
        let navItem = UINavigationItem(title: "Transportation")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor.blackColor()
        
        navItem.leftBarButtonItem = homeItem
        transportNavBar.setItems([navItem], animated: false)
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 33, 33)
        
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
