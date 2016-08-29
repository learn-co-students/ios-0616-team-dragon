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
    
    var comparisonData: ScoreModel?
    var percentageComparisonData: ScoreModel?
    
    var dataArray = [String]()
    var originArray = [String]()
    
    var detailsArray = ["Economic","Education","Transit", "Diversity"]
    var statsNavBar: UINavigationBar = UINavigationBar()
    
    var store = DataStore.sharedInstance
    var storeCalculator = ScoreCalculator()
    var dataSetNames: [String] = []
    var dataSetScores: [String] = []
    
    var tabCityDataSets: [DataSetModel] = []
    var tabUSDataSets: [DataSetModel] = []
    
    let navItem = UINavigationItem(title: "Statistics")
    let homeItem = UIBarButtonItem.init(title: "Home",
                                        style: .Done,
                                        target: nil,
                                        action: #selector(dismissView))
    
    
    
    
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
    
    //    override func scrollViewDidScroll(scrollView: UIScrollView) {
    //        let headerView = self.tableView.tableHeaderView as! ResultView
    //        headerView.scrollViewDidScroll(scrollView)
    //    }
    
    
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
    
    override func tableView(tableView: UITableView,
                            heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 115
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.store.cityScoresByDataSet.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SearchResultCell(style: .Default, reuseIdentifier: "myIdentifier")
        
        cell.resultLocationNameLabel.text = "\(self.dataSetNames[indexPath.row]) score"
        cell.comparisonScoreLabel.text = self.dataSetScores[indexPath.row]
        
        cell.resultLocationNameLabel.textColor = UIColor.blackColor()
        //cell.comparisonScoreLabel.textColor = UIColor.blackColor()
        if cell.comparisonScoreLabel.text == "Very Low"{cell.comparisonScoreLabel.textColor = UIColor.redColor()}
            else if cell.comparisonScoreLabel.text == "Average"{cell.comparisonScoreLabel.textColor = UIColor(netHex:0xE8B20A)}
        else {cell.comparisonScoreLabel.textColor = UIColor.blackColor()}
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.resultLocationNameLabel.snp_makeConstraints { (make) -> Void in
//            make.height.equalTo(66)
//            make.width.equalTo(175)
//            make.bottom.equalTo(-10)
//            make.center.equalTo(cell)
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
    
    
    
    
    
//    override func tableView(tableView: UITableView,
//                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        guard let
//            economicData = self.comparisonData?.getEconomicScore(),
//            educationData = self.comparisonData?.getEducationScore(),
//            transitData = self.comparisonData?.getTransitScore(),
//            demographicData = self.comparisonData?.getDemographicScore()
//            else {
//                fatalError()
//        }
//        
//        guard let
//            originEconomicData = self.comparisonData?.getEconomicScore().1,
//            originEducationData = self.comparisonData?.getEducationScore(),
//            originTransitData = self.comparisonData?.getTransitScore(),
//            originDemographicData = self.comparisonData?.getDemographicScore()
//            else {
//                fatalError()
//        }
//        
//        
//        
//        
//        self.dataArray = [String(economicData), String(educationData), String(transitData), String(demographicData)]
//        self.originArray = [String(originEconomicData), String(originEducationData), String(originTransitData), String(originDemographicData)]
//        
////        print("--------------")
//        //print("\(self.dataArray)")
//        //if let compare = self.comparisonData?.getScoresArray() {
//        //    print("COMPARE")
//        //    print(compare)
//       // }
//        //print(self.comparisonData.getScoresArray())
//        ///print(self.dataArray)
//        //print(self.originArray)
//        //        print(points)
//        //        print(economicData)
//        
//        //self.dataArray[indexPath.row].0
//        guard let compare = self.comparisonData?.getScoresArray() else { fatalError() }
//        //guard let data = dataArray[indexPath.row] else { fatalError() }
//        print(compare)
//       // print("---------")
//       // print("DATA \(self.dataArray[indexPath.row])")
////       print(compare)
//       // print("---------")
//        let cell = SearchResultCell(style: UITableViewCellStyle.Default,
//                                    reuseIdentifier: "myIdentifier",
//                                    parameterDescription: self.detailsArray[indexPath.row],
//                                    description: compare[indexPath.row],
//                                    score: compare[indexPath.row])
//
//        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        cell.comparisonScoreLabel.hidden = true
//        return cell
//    }
    
//    override func tableView(tableView: UITableView,
//                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
////        print(self.detailsArray[indexPath.row])
//    }
    
    
    func setupNavBar() {
        
        self.statsNavBar = NavBar().setup()
        self.view.addSubview(self.statsNavBar)
        self.navItem.leftBarButtonItem = self.homeItem
        self.navItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.statsNavBar.setItems([self.navItem],
                                  animated: false)
        
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
        dismissViewControllerAnimated(true,
                                      completion: nil)
    }
    
    // MARK: - Setting up constraints
    
    func setupConstraints() {
        self.statsNavBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(20)
            make.width.equalTo(view)
        }
    }
    
}
