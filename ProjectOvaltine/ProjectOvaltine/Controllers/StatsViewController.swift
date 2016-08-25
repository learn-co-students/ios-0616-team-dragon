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
    
    var detailsArray = ["Economic","Education","Transit", "Demographic"]
    var statsNavBar: UINavigationBar = UINavigationBar()
    
    var store = DataStore.sharedInstance
    let navItem = UINavigationItem(title: "Statistics")
    let homeItem = UIBarButtonItem.init(title: "Home",
                                        style: .Done,
                                        target: nil,
                                        action: #selector(dismissView))
    
    
    // MARK: - Loading view and UI Elements
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 70
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.detailsArray.count
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // let points = self.comparisonData?.getScoresArray()
        
        let economicData = self.comparisonData?.getEconomicScore().0
        let educationData = self.comparisonData?.getEducationScore()
        let transitData = self.comparisonData?.getTransitScore()
        let demographicData = self.comparisonData?.getDemographicScore()
        
        let originEconomicData = self.comparisonData?.getEconomicScore().0
        let originEducationData = self.comparisonData?.getEducationScore()
        let originTransitData = self.comparisonData?.getTransitScore()
        let originDemographicData = self.comparisonData?.getDemographicScore()
        
        
        
        
        self.dataArray = [String(economicData!), String(educationData!), String(transitData!), String(demographicData!)]
        self.originArray = [String(originEconomicData!), String(originEducationData!), String(originTransitData!), String(originDemographicData!)]
        
        ///print(self.dataArray)
        //print(self.originArray)
        //        print(points)
        //        print(economicData)
        
        let cell = SearchResultCell(style: UITableViewCellStyle.Default,
                                    reuseIdentifier: "myIdentifier",
                                    parameterDescription: self.detailsArray[indexPath.row],
                                    description: self.originArray[indexPath.row],
                                    score: self.dataArray[indexPath.row])
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.detailsArray[indexPath.row])
    }
    
    
    func setupNavBar() {
        
        self.statsNavBar = NavBar().setup()
        self.view.addSubview(self.statsNavBar)
        self.navItem.leftBarButtonItem = self.homeItem
        self.navItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
        self.statsNavBar.setItems([self.navItem],
                                  animated: false)
        
        self.statsNavBar.alpha = 0.6
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "settings-4"),
                        forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed),
                         forControlEvents: UIControlEvents.TouchUpInside)
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
    
    func settingButtonPushed() {
        print("Settings Pushed")
    }
}
