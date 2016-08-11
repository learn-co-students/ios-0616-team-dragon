//
//  TabViewController1.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SwiftSpinner

class TabViewController1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var detailsArray = ["Finance","Education","Transportation", "Demographics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        navBar()
        statsTableView()
        
   
    }
    
    func statsTableView() {
        
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return detailsArray.count
        }
        return detailsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        cell.myLabel1.text = detailsArray[indexPath.row]
        cell.myLabel2.text = "\(indexPath.row + 1)"
        cell.myLabel3.text = "Label"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(detailsArray[indexPath.row])
    }

    func graphImage() {
        //********** creating UIImageView Programmatically******//

        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.magentaColor()
        
        navBar()
        
        graphImage()
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        
//        SwiftSpinner.showWithDuration(1.9, title: "TEAM DRAGON")
//        
//        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
//    }
    

    
    func navBar() {

        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
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
    }
    
    func dismissView() {

        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))

        
        let button: UIButton = UIButton(type: .Custom)
        
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
        
        navItem.rightBarButtonItem = barButton
        
    }
    
    
    
    func settingButtonPushed() {

        
        

    }
}
