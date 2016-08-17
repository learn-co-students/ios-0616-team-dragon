//
//  EducationDataViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit

class EducationDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["High School Graduate","College Graduate","etc."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex:0xFFFFFF)
        self.navBar()
        self.resultsTableView()
    }
    func resultsTableView() {
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame.origin.y += 66
        //tableView.backgroundColor = UIColor(patternImage: UIImage(named:"edu.png")!)
        tableView.backgroundColor = UIColor(netHex:0xE8BD7C)
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
        cell.myLabel1.font = UIFont(name:"Univers Ultra Condensed", size:21)
        cell.myLabel1?.layer.shadowColor = UIColor(netHex:0xE8BD7C).CGColor
        cell.myLabel1?.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        cell.myLabel1?.layer.shadowOpacity = 1.0
        cell.myLabel1?.layer.shadowRadius = 2.0
        cell.myButton1.addTarget(self, action: #selector(EducationDataViewController.pressedButton1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.myButton2.addTarget(self, action: #selector(EducationDataViewController.pressedButton2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(netHex:0xFFFFFF)        }
        else {
            cell.backgroundColor = UIColor(netHex:0xFFFFFF)
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
        let educationNavBar = NavBar().setup()
        self.view.addSubview(educationNavBar)
        educationNavBar.barTintColor = UIColor(netHex:0xFFDA00)
        let navItem = UINavigationItem(title: "Education")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor(netHex:0x000000)
        
        navItem.leftBarButtonItem = homeItem
        educationNavBar.setItems([navItem], animated: false)
        educationNavBar.alpha = 0.6
        
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