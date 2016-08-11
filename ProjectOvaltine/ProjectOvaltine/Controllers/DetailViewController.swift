//
//  DetailViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//
import UIKit
import MapKit
import SwiftSpinner

class DetailViewController: UITabBarController, UITabBarControllerDelegate, Tabable, Navigable {
    
    let resultView = ResultView()
    var resultDataPointTitleLabel: UILabel!
    var resultMapView: MKMapView!
    var resultDataPointLabel: UILabel!

    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
        self.resultDataPointLabel = UILabel()
        self.resultDataPointTitleLabel = UILabel()
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.blueColor()
        self.view.backgroundColor=UIColor.lightGrayColor()
        self.initMapBlock()
        self.initSearchTextField()
    }
    
    override func loadView() {
        super.loadView()
        self.setupTabBar()
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.showWithDuration(1.3, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
    }
    
    func searchButtonTapped(){
        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
        let detailVC = DetailViewController()
        SwiftSpinner.hide()
        self.presentViewController(detailVC!, animated: true, completion: nil)
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
    
    func initMapBlock() {
        let mapView = MKMapView()
        mapView.frame = CGRectMake(0, 80, self.view.frame.width, 666)
        mapView.mapType = MKMapType.Standard
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        self.view.addSubview(mapView)
    }
    
    func initSearchTextField() {
        let myTextField = UITextField(frame: CGRect(x: 11, y: 20, width: self.view.frame.width-69, height: 40.00))
        myTextField.backgroundColor = UIColor.whiteColor()
        myTextField.placeholder = "Enter Zipcode"
        myTextField.textAlignment = NSTextAlignment.Center
        myTextField.borderStyle = UITextBorderStyle.Line
        myTextField.secureTextEntry = false
        self.view.addSubview(myTextField)
    }
    
    func setUpView() {
        let mapFrame = CGRect(x: 0, y: 0, width: 150, height: 300)
        self.resultMapView.frame = mapFrame
        
        let viewFrame = CGRect(x: 0, y: 0, width: 150, height: 300)
        self.view = UIView(frame: viewFrame)
        self.view.backgroundColor = UIColor.clearColor()
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        let newView = UIView(frame: CGRect(x: (width * 0.10), y: (height * 0.25), width: (width * 0.75), height: (height / 2)))
        newView.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(self.resultMapView)
        self.view.addSubview(newView)
    }
}
