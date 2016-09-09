//
//  DetailViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit
import SwiftSpinner

class StatsViewController: UITableViewController {
    // MARK: - Properties
    
    var store = DataStore.sharedInstance
    var comparisonData: ScoreModel?
    var percentageComparisonData: ScoreModel?
    var dataArray = [String]()
    var originArray = [String]()
    var detailsArray = ["Economic","Education","Transit", "Diversity"]
    var statsNavBar: UINavigationBar = UINavigationBar()
    var storeCalculator = ScoreCalculator()
    var dataSetNames: [String] = []
    var dataSetScores: [String] = []
    var tabCityDataSets: [DataSetModel] = []
    var tabUSDataSets: [DataSetModel] = []
    
    let navItem = UINavigationItem(title: "Statistics")
    let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
    
    // MARK: - Loading view and UI Elements
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storeCalculator.createRatings()
        self.populateScoreArrays()
        self.tableView.tableHeaderView = ResultView.init(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 335));
        self.comparisonData = self.store.comparisonData
        self.percentageComparisonData = self.store.comparisonPercentageData
        self.setupNavBar()
        self.setupConstraints()
    }
    
    func populateScoreArrays() {
        self.dataSetNames.removeAll()
        self.dataSetScores.removeAll()
        
        for (name, score) in self.store.cityScoresByDataSet {
            self.dataSetNames.append(name)
            self.dataSetScores.append(score)
        }
    }
    
    
    func statsTableView() {
        let tableView = UITableView(frame: view.bounds,
                                    style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.view.sendSubviewToBack(tableView)
        tableView.frame.origin.y += 366
        self.edgesForExtendedLayout = .None
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 115
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.cityScoresByDataSet.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SearchResultCell(style: .Default, reuseIdentifier: "myIdentifier")
        cell.resultLocationNameLabel.text = "\(self.dataSetNames[indexPath.row]) score"
        cell.comparisonScoreLabel.text = self.dataSetScores[indexPath.row]
        cell.resultLocationNameLabel.textColor = UIColor.blackColor()
       
        if cell.comparisonScoreLabel.text == "Very Low"{cell.comparisonScoreLabel.textColor = UIColor(netHex: 0xF25C5C)}
        else if cell.comparisonScoreLabel.text == "Low"{cell.comparisonScoreLabel.textColor = UIColor(netHex: 0xF6A6A6)}
        else if cell.comparisonScoreLabel.text == "Average"{cell.comparisonScoreLabel.textColor = UIColor(netHex: 0xFFB34D)}
        else if cell.comparisonScoreLabel.text == "High"{cell.comparisonScoreLabel.textColor = UIColor(netHex: 0xA6F6AF)}
        else if cell.comparisonScoreLabel.text == "Very High"{cell.comparisonScoreLabel.textColor = UIColor(netHex: 0x6BF67B)}
        else {cell.comparisonScoreLabel.textColor = UIColor.blackColor()}
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.resultLocationNameLabel.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(66)
            make.left.equalTo(cell).offset(20)
            make.top.equalTo(cell).offset(10)
        }
        
        cell.scoreLabel.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(45)
            make.left.equalTo(cell).offset(20)
            make.top.equalTo(cell).offset(10)
        }
        
        cell.comparisonScoreLabel.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(66)
            make.width.equalTo(33)
            make.left.equalTo(99)
            make.top.equalTo(cell).offset(50)
        }
        
        cell.scoreLabel.hidden = true
        return cell
        
    }
    
    func setupNavBar() {
        
        self.statsNavBar = NavBar().setup()
        self.view.addSubview(self.statsNavBar)
        self.navItem.leftBarButtonItem = self.homeItem
        self.navItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.statsNavBar.setItems([self.navItem], animated: false)
        self.statsNavBar.alpha = 1.0
    
        let button: UIButton = UIButton(type: .Custom)
        button.tintColor = UIColor.whiteColor()
        button.frame = CGRectMake(3, 3, 25, 25)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        self.navItem.rightBarButtonItem = barButton
    }
    
    // MARK: - Action for when home button is pressed
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Setting up constraints
    
    func setupConstraints() {
        self.statsNavBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(20)
            make.width.equalTo(view)
        }
    }
    
}
