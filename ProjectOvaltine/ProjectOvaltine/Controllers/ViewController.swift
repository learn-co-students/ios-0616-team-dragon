//
//  ViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/4/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient.sharedInstance
    
    var cityData: [CitySDKData] = []

    let level = "county"
    let zip = "10001"
    let api = "acs5"
    let year = "2014"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.store.getCitySDKData({
            print(self.store.cityDataPoints.first?.age)
        })
        
<<<<<<< HEAD
      
=======
        
        
        
//        print(api.sendAPIRequest(self.level, zip: self.zip, api: self.api, year: self.year, completion: ()->()))
>>>>>>> master
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

