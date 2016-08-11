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

class AppController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let searchController = UISearchBar.init()
    
    var currentViewController: UIViewController!
    var containerView: UIView!
    
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient.sharedInstance
    var cityData: [CitySDKData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.lightGrayColor()
        //self.initHeaderBanner()
        self.initMapBlock()
//        self.initSearchButton()
//        self.initSearchTextField()
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
        searchController.placeholder = "Enter Location"
        searchController.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 66)
        let topConstraint = NSLayoutConstraint(item: searchController, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        searchController.delegate = self
        self.view.addSubview(searchController)
        self.view.addConstraint(topConstraint)
    }
 
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
        let detailVC = DetailViewController()
        SwiftSpinner.hide()
        self.showViewController(detailVC, sender: searchBar)
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
    
    func initMapBlock() {
        let mapView = MKMapView()
        mapView.frame = CGRectMake(0, 66, self.view.frame.width, 700)
        mapView.mapType = MKMapType.Standard
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        self.view.addSubview(mapView)
    }
    
}

extension AppController {
    private func loadInitialViewController() {
        //self.currentViewController = loadViewControllerWith()
       // self.addCurrentViewController(self.currentViewController)
        //not implemented yet
    }
    private func addNotificationObservers() {
        //not implemented yet
    }
    
    private func addCurrentViewController(controller: UIViewController) {
        self.addChildViewController(controller)
        self.containerView.addSubview(controller.view)
        controller.view.frame = self.containerView.bounds
        controller.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        controller.didMoveToParentViewController(self)
    }
}