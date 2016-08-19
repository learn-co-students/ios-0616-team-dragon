//
//  FinanceDataViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit

class FinanceDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["Median Income","Unemployment Rate","etc."]
    
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
        self.view.addSubview(tableView)
        tableView.frame.origin.y += 60
        tableView.backgroundColor = UIColor(patternImage: UIImage(named:"yellow.png")!)
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
        cell.myLabel1.font = UIFont(name:"Univers Ultra Condensed", size:21)
        cell.myLabel1.textColor = UIColor(netHex:0x000000)
        
        
        cell.myButton1.addTarget(self, action: #selector(FinanceDataViewController.pressedButton1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.myButton2.addTarget(self, action: #selector(FinanceDataViewController.pressedButton2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.clearColor()
        } else {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(self.myArray[indexPath.row])
    }
    
    func navBar() {
        let financeNavBar = NavBar().setup()
        self.view.addSubview(financeNavBar)
        financeNavBar.barTintColor = UIColor(netHex:0xFFFF03)
        let navItem = UINavigationItem(title: "Finance")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor(netHex:0x000000)
        
        navItem.leftBarButtonItem = homeItem
        financeNavBar.setItems([navItem], animated: false)
        financeNavBar.alpha = 0.6
        
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