//
//  InitialViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit
import MapKit
import SwiftSpinner


class InitialViewController: UIViewController {
    var detailsArray = ["Finance","Education","Transportation", "Demographics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        navBar()
        statsTableView()
        ratingTextView()
    }
    
    func ratingTextView() {
        
        let text1 = "9.5"
        
        let label = UILabel(frame : CGRect(x:60, y:90, width:90, height:100))
        view.addSubview(label)
        
        label.backgroundColor = UIColor.blueColor()
        label.text = text1
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name:"AppleSDGothicNeo-Light", size:66)
        label.sendSubviewToBack(label)
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
        let cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier",locationName: "New York City", description:"Description", score:"90")
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
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
//    static let sharedInstance = InitialViewController()
//    let store = DataStore.sharedInstance
//    let cityAPI = CitySDKAPIClient.sharedInstance
//    let jobsAPI = USAJobsAPIClient.sharedInstance
//    var cityData: [CitySDKData] = []
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor=UIColor.lightGrayColor()
//        self.initMapBlock()
//        self.initSearchButton()
//        self.initSearchTextField()
//    }
//    
//    func searchButtonTapped(){
//        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
//        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
//        let detailVC = DetailViewController()
//        SwiftSpinner.hide()
//        self.presentViewController(detailVC, animated: true, completion: nil)
//    }
//    
//    func initHeaderBanner() {
//        let projectName = UIButton(frame: CGRectMake(20, 20, self.view.frame.width-40, 40))
//        projectName.backgroundColor=UIColor.blueColor()
//        projectName.setTitle("PROJECT OVALTINE", forState: .Normal)
//        projectName.setTitleColor(UIColor.yellowColor(), forState: .Normal)
//        projectName.alpha=0.6
//        projectName.layer.borderWidth=0.3
//        projectName.layer.cornerRadius=2
//        self.view.addSubview(projectName)
//    }
//    
//    func initMapBlock() {
//        let mapView = MKMapView()
//        mapView.frame = CGRectMake(0, 80, self.view.frame.width, 666)
//        mapView.mapType = MKMapType.Standard
//        mapView.zoomEnabled = true
//        mapView.scrollEnabled = true
//        self.view.addSubview(mapView)
//    }
//    func initSearchButton() {
//        let button=UIButton(frame: CGRectMake(366, 20, 40, 40))
//        button.backgroundColor = UIColor.whiteColor()
//        button.setImage(UIImage(named: "active-search.png"), forState: UIControlState.Normal)
//        button.setTitleColor(UIColor.yellowColor(), forState: .Normal)
//        button.alpha=1.0
//        button.layer.borderWidth = 1.3
//        button.layer.cornerRadius = 20
//        //*** button action***//
//        button.addTarget(self, action: #selector(AppController.searchButtonTapped), forControlEvents: .TouchUpInside)
//        button.titleLabel!.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(button)
//    }
//    
//    func initSearchTextField() {
//        let myTextField = UITextField(frame: CGRect(x: 11, y: 20, width: self.view.frame.width-69, height: 40.00))
//        myTextField.backgroundColor = UIColor.whiteColor()
//        myTextField.placeholder = "Enter Zipcode"
//        myTextField.textAlignment = NSTextAlignment.Center
//        myTextField.borderStyle = UITextBorderStyle.Line
//        myTextField.secureTextEntry = false
//        self.view.addSubview(myTextField)
//    }
//}