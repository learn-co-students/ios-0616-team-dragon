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
    static let sharedInstance = InitialViewController()
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient.sharedInstance
    let jobsAPI = USAJobsAPIClient.sharedInstance
    var cityData: [CitySDKData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.lightGrayColor()
        //self.initHeaderBanner()
        self.initMapBlock()
        self.initSearchButton()
        self.initSearchTextField()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named:"any.jpeg")!)
    }
    
    
    //    override func viewDidAppear(animated: Bool) {
    //        SwiftSpinner.showWithDuration(1.3, title: "TEAM DRAGON")
    //        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
    //    }
    
    func searchButtonTapped(){
        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
        let detailVC = DetailViewController()
        SwiftSpinner.hide()
        self.presentViewController(detailVC, animated: true, completion: nil)
    }
    
    func initHeaderBanner() {
        let projectName = UIButton(frame: CGRectMake(20, 20, self.view.frame.width-40, 40))
        projectName.backgroundColor=UIColor.blueColor()
        projectName.setTitle("PROJECT OVALTINE", forState: .Normal)
        projectName.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        projectName.alpha=0.6
        projectName.layer.borderWidth=0.3
        projectName.layer.cornerRadius=2
        self.view.addSubview(projectName)
    }
    
    //    func initSummaryBlock() {
    //        //******** creating label programmatically*******//
    //        let label2 = UILabel(frame: CGRectMake(20, 80, 375, 450))
    //        //label.center = CGPointMake(160, 284)
    //        label2.textAlignment = NSTextAlignment.Center
    //        label2.backgroundColor = UIColor.lightGrayColor()
    //        label2.text = "SUMMARY                              SUMMARY                  SUMMARY             SUMMARY"
    //        label2.numberOfLines = 6
    //        self.view.addSubview(label2)
    //    }
    
    func initMapBlock() {
        let mapView = MKMapView()
        mapView.frame = CGRectMake(0, 80, self.view.frame.width, 666)
        mapView.mapType = MKMapType.Standard
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        self.view.addSubview(mapView)
    }
    func initSearchButton() {
        let button=UIButton(frame: CGRectMake(366, 20, 40, 40))
        button.backgroundColor = UIColor.whiteColor()
        //button.setTitle("SEARCH", forState: .Normal)
        button.setImage(UIImage(named: "active-search.png"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button.alpha=1.0
        button.layer.borderWidth = 1.3
        button.layer.cornerRadius = 20
        //*** button action***//
        button.addTarget(self, action: #selector(AppController.searchButtonTapped), forControlEvents: .TouchUpInside)
        button.titleLabel!.textAlignment=NSTextAlignment.Center
        self.view.addSubview(button)
    }
    
    func initSearchTextField() {
        let myTextField = UITextField(frame: CGRect(x: 11, y: 20, width: self.view.frame.width-69, height: 40.00))
        myTextField.backgroundColor = UIColor.whiteColor()
        myTextField.placeholder = "Enter Zipcode"
        //myTextField.text = "    Enter here"
        myTextField.textAlignment = NSTextAlignment.Center
        myTextField.borderStyle = UITextBorderStyle.Line
        myTextField.secureTextEntry = false
        self.view.addSubview(myTextField)
    }
}