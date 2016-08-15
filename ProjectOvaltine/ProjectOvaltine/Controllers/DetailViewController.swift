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
        let ratingsView = ResultView()!
        self.view.addSubview(ratingsView)
       // self.ratingsView.sendSubviewToBack(ratingsView)
//        let ratingsText = "9.5"
//        let graphDescription = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
//        let graphDescriptionTextView = UITextView()
//        graphDescriptionTextView.text = graphDescription
//        graphDescriptionTextView.frame = CGRect(x: 10, y:176, width: 300, height:600)
//        let fixedWidth = graphDescriptionTextView.frame.size.width
//        let ratingsLabel = UILabel(frame : CGRect(x:60, y:90, width:90, height:100))
//        graphDescriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//        let newSize = graphDescriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//        var newFrame = graphDescriptionTextView.frame
//        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//        graphDescriptionTextView.frame = newFrame
//        view.addSubview(ratingsLabel)
//        view.addSubview(graphDescriptionTextView)
//        ratingsLabel.backgroundColor = UIColor.blueColor()
//        ratingsLabel.text = ratingsText
//        ratingsLabel.textColor = UIColor.whiteColor()
//        ratingsLabel.font = UIFont(name:"AppleSDGothicNeo-Light", size:66)
//        ratingsLabel.sendSubviewToBack(ratingsLabel)
//        graphDescriptionTextView.sendSubviewToBack(graphDescriptionTextView)
//        
//        
//    
//        
//        
        
        
//        self.graphDescriptionTextView.frame = CGRect(x: 10, y: self.view.frame.height * 0.8, width: 300, height:600)
//        self.graphDescriptionTextView.text =
//        self.graphDescriptionTextView.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
//        self.graphDescriptionTextView.textColor = UIColor.blackColor()
//        let fixedWidth = self.graphDescriptionTextView.frame.size.width
//        self.graphDescriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//        let newSize = graphDescriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//        var newFrame = graphDescriptionTextView.frame
//        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//        self.graphDescriptionTextView.frame = newFrame
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
        let cell = SearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier",parameterDescription: "New York City", description: "Description", score:"90")
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if self.detailsArray[indexPath.row] == "Finance" {
//            let destinationVC = EconomicDataViewController()
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
