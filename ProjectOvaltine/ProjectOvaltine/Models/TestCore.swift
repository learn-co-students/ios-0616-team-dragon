//
//  TestCore.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/22/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TestCore {
    
    let censusAPI = CensusAPIClient()
    let mark = MapKitViewController()
    
    
    init() {
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n INITITED")
        
    }
    
    func testCore() {
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n RUNNINGING")
        if let mark = mark.placemark {
             print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n RUNNINGING")
            censusAPI.requestDataForLocation(placemark: mark) { (city, county, state, us) in
                print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n \(city)")
                print(county)
            }
            
        }
    }
}
