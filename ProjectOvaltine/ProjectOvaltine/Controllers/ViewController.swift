//
//  ViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/4/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient.sharedInstance
    let censusAPI = CensusAPIClient()
    
    var cityData: [CitySDKData] = []
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //censusAPI.sendAPIRequest()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

