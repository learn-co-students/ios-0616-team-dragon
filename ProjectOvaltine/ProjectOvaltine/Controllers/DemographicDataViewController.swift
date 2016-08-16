//
//  DemographicDataViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit

class DemographicDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["Diversity","Population","etc."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        navBar()
        resultsTableView()
    }
    func resultsTableView() {
        
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        let color = UIColor(netHex:0x4F57DE)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame.origin.y += 66
        //tableView.backgroundColor = UIColor(patternImage: UIImage(named:"edu.png")!)
        tableView.backgroundColor = color
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        let color = UIColor(netHex:0x4F57DE)
        cell.myLabel1.text = myArray[indexPath.row]
        cell.myLabel1.font = UIFont(name:"Futura", size:20)
        cell.myLabel1?.layer.shadowColor = color.CGColor
        cell.myLabel1?.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        cell.myLabel1?.layer.shadowOpacity = 1.0
        cell.myLabel1?.layer.shadowRadius = 2.0
        
        //cell.myLabel2.text = "\(indexPath.row + 1)"
        cell.myButton1.addTarget(self, action: #selector(DemographicDataViewController.pressedButton1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.myButton2.addTarget(self, action: #selector(DemographicDataViewController.pressedButton2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        let color = UIColor(netHex:0x6CD4E8)
        //        let color2 = UIColor(netHex:0x2DC5E8)
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor.whiteColor()        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor()
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
        demographicNavBar.barTintColor = UIColor.blueColor()
        let navItem = UINavigationItem(title: "Demographics")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor.blackColor()
        
        navItem.leftBarButtonItem = homeItem
        demographicNavBar.setItems([navItem], animated: false)
        demographicNavBar.alpha = 0.6
        
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

