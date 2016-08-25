//
//  EducationDataViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/7/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SnapKit

class EducationDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    let store = DataStore.sharedInstance
    var myArray = ["High School Graduate","College Graduate","etc."]
    var comparisonData: ScoreModel?
    var percentageComparisonData: ScoreModel?
    let searchedLabel = UILabel()
    let currentLabel = UILabel()
    
    // MARK: - Loading UI Elements and View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex:0xFFFFFF)
        self.comparisonData = self.store.comparisonData
        self.percentageComparisonData = self.store.comparisonPercentageData
        self.navBar()
        self.resultsTableView()
        
        ratingTextView()
        comparisonTextView()
        currentLocationLabel()
        searchedLocationLabel()
    }
    
    // MARK: - Setup labels for tablview
    func currentLocationLabel() {
        
        view.addSubview(currentLabel)
        currentLabel.text = "National Average"
        currentLabel.textAlignment = .Left
        currentLabel.textColor = UIColor.blackColor()
        currentLabel.font = UIFont(name:"Helvetica Light", size:17)
        currentLabel.sendSubviewToBack(currentLabel)
        currentLabel.layer.masksToBounds = true
        currentLabel.frame = CGRectMake(20, 75, self.view.bounds.width * 0.5 - 20, 30)
    }
    
    func searchedLocationLabel() {
        
        var shortenedCity = ""
        
        if let cityName = self.store.cityName {
            shortenedCity = CensusAPIClient().actualName(cityName)}
        
        view.addSubview(searchedLabel)
        searchedLabel.text = shortenedCity
        searchedLabel.textAlignment = .Right
        searchedLabel.textColor = UIColor.blackColor()
        searchedLabel.font = UIFont(name:"Helvetica Light", size:17)
        searchedLabel.sendSubviewToBack(searchedLabel)
        searchedLabel.layer.masksToBounds = true
        searchedLabel.frame = CGRectMake(self.view.bounds.width * 0.5, 75, self.view.bounds.width * 0.5 - 20, 30)
    }
    
    func ratingTextView() {
        
        let ratingLabel = UILabel()
        view.addSubview(ratingLabel)
        ratingLabel.text = "9.5"
        ratingLabel.backgroundColor = UIColor(netHex:0xFFFFFF)
        ratingLabel.textColor = UIColor.blackColor()
        //        ratingLabel.layer.borderWidth = 3
        //        ratingLabel.layer.borderColor = UIColor.blackColor().CGColor
        ratingLabel.adjustsFontSizeToFitWidth = true
        ratingLabel.font = UIFont(name:"Helvetica Light", size:33)
        ratingLabel.sendSubviewToBack(ratingLabel)
        ratingLabel.layer.masksToBounds = true
        //ratingLabel.layer.cornerRadius = 33
        ratingLabel.textAlignment = NSTextAlignment.Center
        ratingLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(10)
            make.top.equalTo(view).offset(110)
            make.width.equalTo(66)
            make.height.equalTo(66)
        }
    }
    
    func comparisonTextView() {
        
        let comparisonLabel = UILabel()
        view.addSubview(comparisonLabel)
        comparisonLabel.text = "9.5"
        comparisonLabel.backgroundColor = UIColor(netHex:0xFFFFFF)
        comparisonLabel.textColor = UIColor.blackColor()
        //        comparisonLabel.layer.borderWidth = 3
        //        comparisonLabel.layer.borderColor = UIColor.blackColor().CGColor
        comparisonLabel.adjustsFontSizeToFitWidth = true
        comparisonLabel.font = UIFont(name:"Helvetica Light", size:33)
        comparisonLabel.sendSubviewToBack(comparisonLabel)
        comparisonLabel.layer.masksToBounds = true
        //comparisonLabel.layer.cornerRadius = 33
        comparisonLabel.textAlignment = NSTextAlignment.Center
        comparisonLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view).offset(110)
            make.width.equalTo(66)
            make.height.equalTo(66)
        }
    }
    
    func resultsTableView() {
        let tableView = UITableView(frame: view.bounds,
                                    style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.frame.origin.y += 166
        tableView.backgroundColor = UIColor(netHex:0xFFFFFF)
    }
    
    func tableView(tableView: UITableView,
                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let educationComparisonData = self.comparisonData?.getEducationScore() else { fatalError() }
        return educationComparisonData.1.keys.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let educationComparisonData = self.comparisonData?.getEducationScore() else { fatalError() }
//        print(educationComparisonData.0)
        var educationKeys = Array(educationComparisonData.1.keys)
//        print(educationComparisonData.2)
        let cell = SearchResultCell(style: UITableViewCellStyle.Default,
                                    reuseIdentifier: "myIdentifier")
        cell.resultDescription.text = educationKeys[indexPath.row]
        cell.resultLocationNameLabel.text = educationKeys[indexPath.row]
        cell.resultLocationNameLabel.adjustsFontSizeToFitWidth = true
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //        if (indexPath.row % 2 == 0) {
        //            cell.backgroundColor = UIColor.clearColor()
        //        } else {
        //            cell.backgroundColor = UIColor.clearColor()
        //        }
        return cell
    }
    
    func pressedButton1(sender: UIButton) {
        print("Pressed Button 1")
    }
    
    func pressedButton2(sender: UIButton) {
        print("Pressed Button 2")
    }
    
    func tableView(tableView: UITableView,
                   didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(myArray[indexPath.row])
    }
    
    // MARK: - Navigation Bar setup
    
    func navBar() {
        let financeNavBar = NavBar().setup()
        self.view.addSubview(financeNavBar)
        financeNavBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(20)
            make.width.equalTo(view)
        }
        //navBar.backgroundColor = UIColor(netHex:0xFFFF03)
        financeNavBar.barTintColor = UIColor(red:0.36, green:0.49, blue:0.55, alpha:1.0)
        
        let navItem = UINavigationItem(title: "Education")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        homeItem.tintColor = UIColor(netHex:0xFFFFFF)
        navItem.leftBarButtonItem = homeItem
        financeNavBar.setItems([navItem], animated: false)
        
        
        let button: UIButton = UIButton(type: .Custom)
        //button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
//        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 25, 25)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navItem.rightBarButtonItem = barButton
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func settingButtonPushed() {
//        print("Settings Pushed")
//    }
    
}