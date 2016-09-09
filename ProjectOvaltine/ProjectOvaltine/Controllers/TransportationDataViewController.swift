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
    // MARK: - Properties
    
    let store = DataStore.sharedInstance
    //var myArray = ["High School Graduate","College Graduate","etc."]
    
    var tabCityDataSets: [DataSetModel] = []
    var tabUSDataSets: [DataSetModel] = []
    
    var comparisonData: ScoreModel?
    var percentageComparisonData: ScoreModel?
    let searchedLabel = UILabel()
    let currentLabel = UILabel()
    let yourCityLabel = UILabel()
    
    // MARK: - Loading UI Elements and View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabCityDataSets = self.tabSets(city: true, type: Hints.transporation)
        self.tabUSDataSets = self.tabSets(city: false, type: Hints.transporation)
        self.comparisonData = self.store.comparisonData
        self.percentageComparisonData = self.store.comparisonPercentageData
        self.view.backgroundColor = UIColor(netHex:0xFFFFFF)
        self.navBar()
        self.resultsTableView()
        //ratingTextView()
        comparisonTextView()
        self.currentLocationLabel()
        self.yourLocationLabel()
        searchedLocationLabel()
    }
    
    func tabSets(city city: Bool, type: String) -> [DataSetModel] {
        var sets: [DataSetModel] = []
        
        if city {
            sets = store.cityModel.dataSets.filter({ (dataSet) -> Bool in
                dataSet.type == type
            })
        } else {
            sets = store.usModel.dataSets.filter({ (dataSet) -> Bool in
                dataSet.type == type 
            })
        }
        
        for set in sets {
            for (index, value) in set.values.enumerate() {
                if value.name == Hints.total {
                    set.values.removeAtIndex(index)
                }
            }
        }
        for set in sets {
            set.values.sortInPlace({ (valueModel1, valueModel2) -> Bool in
                valueModel1.name < valueModel2.name
            })
        }
        return sets.sort({ (dataSetModel1, dataSetModel2) -> Bool in
            dataSetModel1.name < dataSetModel2.name
        })
        
    }
    
    // MARK: - Setup labels for tablview
    func currentLocationLabel() {
        
        view.addSubview(currentLabel)
        currentLabel.text = "National Average"
        currentLabel.textAlignment = .Left
        currentLabel.textColor = UIColor.blackColor()
        currentLabel.font = UIFont(name:"Helvetica Light", size:12)
        currentLabel.sendSubviewToBack(currentLabel)
        currentLabel.layer.masksToBounds = true
        currentLabel.frame = CGRectMake(15, 133, self.view.bounds.width * 0.5 - 20, 30)
    }
    
    func yourLocationLabel() {
        
        view.addSubview(yourCityLabel)
        yourCityLabel.text = "Current City"
        yourCityLabel.textColor = UIColor.blackColor()
        yourCityLabel.font = UIFont(name:"Helvetica Light", size:12)
        yourCityLabel.sendSubviewToBack(currentLabel)
        yourCityLabel.layer.masksToBounds = true
        yourCityLabel.frame = CGRectMake(self.view.frame.width * 0.75, 133, self.view.bounds.width * 0.5 - 20, 30)
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
        searchedLabel.frame = CGRectMake(self.view.bounds.width * 0.28, 75, self.view.bounds.width * 0.5 - 20, 30)
        searchedLabel.textAlignment = NSTextAlignment.Center
    }
    
    func ratingTextView() {
        let ratingLabel = UILabel()
        view.addSubview(ratingLabel)
        ratingLabel.text = "N/A"
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
        comparisonLabel.text = self.store.cityScoresByType[Hints.transporation]
        if comparisonLabel.text == "Very Low"{comparisonLabel.textColor = UIColor(netHex: 0xF25C5C)}
        else if comparisonLabel.text == "Low"{comparisonLabel.textColor = UIColor(netHex: 0xF6A6A6)}
        else if comparisonLabel.text == "Average"{comparisonLabel.textColor = UIColor(netHex: 0xFFB34D)}
        else if comparisonLabel.text == "High"{comparisonLabel.textColor = UIColor(netHex: 0xA6F6AF)}
        else if comparisonLabel.text == "Very High"{comparisonLabel.textColor = UIColor(netHex: 0x6BF67B)}
        else {comparisonLabel.textColor = UIColor.blackColor()}
        comparisonLabel.backgroundColor = UIColor(netHex:0xFFFFFF)
//        comparisonLabel.textColor = UIColor.blackColor()
//        comparisonLabel.layer.borderWidth = 3
//        comparisonLabel.layer.borderColor = UIColor.blackColor().CGColor
        comparisonLabel.adjustsFontSizeToFitWidth = true
        comparisonLabel.font = UIFont(name:"Helvetica Light", size:25)
        comparisonLabel.sendSubviewToBack(comparisonLabel)
        comparisonLabel.layer.masksToBounds = true
        //comparisonLabel.layer.cornerRadius = 33
        comparisonLabel.textAlignment = NSTextAlignment.Center
         comparisonLabel.frame = CGRectMake(self.view.bounds.width * 0.28, 115, self.view.bounds.width * 0.5 - 20, 30)
    }
    
    func resultsTableView() {
        let tableView = UITableView(frame: view.bounds,
                                    style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.frame.origin.y += 166
        tableView.frame.size.height = self.view.bounds.height - 206
        tableView.backgroundColor = UIColor(netHex:0xFFFFFF)
    }
    
    func tableView(tableView: UITableView,
                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 115
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tabCityDataSets.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabCityDataSets[section].values.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tabCityDataSets[section].name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SearchResultCell(style: .Default, reuseIdentifier: "myIdentifier")
        
        let usDataSet = self.tabUSDataSets[indexPath.section]
        let cityDataSet = self.tabCityDataSets[indexPath.section]
        let usValue = usDataSet.values[indexPath.row]
        let cityValue = cityDataSet.values[indexPath.row]
        
        var usValueToDisplay = usValue.absoluteValue
        var cityValueToDisplay = cityValue.absoluteValue
        if usDataSet.displayPercent { usValueToDisplay = usValue.percentValue }
        if cityDataSet.displayPercent { cityValueToDisplay = cityValue.percentValue }
        
        cell.resultLocationNameLabel.text = tabCityDataSets[indexPath.section].values[indexPath.row].name
        cell.resultLocationNameLabel.textColor = UIColor.blackColor()
        cell.resultLocationNameLabel.textAlignment = NSTextAlignment.Center
        cell.scoreLabel.text = usValueToDisplay
        cell.scoreLabel.textColor = UIColor.blackColor()
        cell.comparisonScoreLabel.text = cityValueToDisplay
        cell.comparisonScoreLabel.textColor = UIColor.blackColor()
        
        return cell
    }
    
    
    func pressedButton1(sender: UIButton) {
        print("Pressed Button 1")
    }
    
    func pressedButton2(sender: UIButton) {
        print("Pressed Button 2")
    }
    
    
    func navBar() {
        let financeNavBar = NavBar().setup()
        self.view.addSubview(financeNavBar)
        financeNavBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(20)
            make.width.equalTo(view)
        }
        //navBar.backgroundColor = UIColor(netHex:0xFFFF03)
        financeNavBar.barTintColor = UIColor(red:0.36, green:0.49, blue:0.55, alpha:1.0)
        
        let navItem = UINavigationItem(title: "Transportation")
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