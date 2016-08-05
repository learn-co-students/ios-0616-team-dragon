//
//  CensusAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Alamofire

class CensusAPIClient {
    // MARK: Path Router
    let url: String? = "https://api.census.gov"
    let key = Constants.CENSUS_API_KEY
    
    func sendAPIRequest() -> [CensusData] {
        guard let urlString = url
            else {
                print("ERROR: Unable to get url path for starred status")
                return [CensusData()]
        }
        
        return [CensusData()]
    }
    
}