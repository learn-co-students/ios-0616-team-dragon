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
<<<<<<< HEAD
    let censusAPI = CensusAPIClient()
=======
    //let censusAPI = CensusAPIClient()
    
    
    
>>>>>>> 3e57809900705c9f6a9801d0bdd3667040fc7c95
    var cityData: [CitySDKData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //censusAPI.sendAPIRequest()
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
            
            if let coords = self.store.cityDataPoints.first?.coordinates {
                print(coords)
            }
        })

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

