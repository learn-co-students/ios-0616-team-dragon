//
//  AppController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MapKit
import SwiftSpinner
import SnapKit

class AppController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, Mapable, Searchable {
    var searchController: UISearchBar = UISearchBar()
    var constraint: NSLayoutConstraint = NSLayoutConstraint()
    var currentViewController: UIViewController!
    var containerView: UIView!
    
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient.sharedInstance
    var cityData: [CitySDKData] = []
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        self.constraint = NSLayoutConstraint()
        self.containerView = UIView()
        super.init(coder:NSCoder.empty())
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.lightGrayColor()
        let searchable = self.setupSearch()
        self.searchController = searchable.0
        self.constraint = searchable.1
        self.initMapBlock()
        self.loadInitialViewController()
        self.addNotificationObservers()
        
       self.searchBar()
        
        self.store.getCitySDKData({
            if let age = self.store.cityDataPoints.first?.age {
                print(age)
            }
            if let name = self.store.cityDataPoints.first?.locationName {
                print(name)
            }
            if let commute = self.store.cityDataPoints.first?.walkingCommuteTime {
                print(commute)
            }
            if let income = self.store.cityDataPoints.first?.incomePerCapita {
                print(income)
            }
            if let education = self.store.cityDataPoints.first?.highSchoolEducation {
                print(education)
            }
            if let geo = self.store.cityDataPoints.first?.coordinates {
                print(geo)
            }
        })
        
        self.view.backgroundColor=UIColor.whiteColor()
        self.initHeaderBanner()
        self.initMapBlock()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named:"any.jpeg")!)
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.showWithDuration(1.3, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
    }

    func searchBar() {
        self.view.addSubview(self.searchController)
        self.view.addConstraint(self.constraint)
    }
 
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
        let detailVC = DetailViewController()
        SwiftSpinner.hide()
        self.showViewController(detailVC!, sender: searchBar)
        searchController.text?.removeAll()
    }
    
    func initHeaderBanner() {
        let projectName = UIButton(frame: CGRectMake(20, 630, self.view.frame.width-40, 40))
        projectName.backgroundColor=UIColor.lightGrayColor()
        projectName.setTitle("PROJECT OVALTINE", forState: .Normal)
        projectName.setTitleColor(UIColor.blackColor(), forState: .Normal)
        projectName.alpha = 0.3
        projectName.layer.zPosition = 3
        projectName.layer.borderWidth=0.3
        projectName.layer.cornerRadius=2
        self.view.addSubview(projectName)
    }
    
}

extension AppController {
    private func loadInitialViewController() {
        
    }

    private func addNotificationObservers() {
        //not implemented yet
    }
    
   func addCurrentViewController(controller: UIViewController) {
        self.addChildViewController(controller)
        self.containerView.addSubview(controller.view)
        controller.view.frame = self.containerView.bounds
        controller.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        controller.didMoveToParentViewController(self)
    }
}