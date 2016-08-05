//
//  CensusAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class CensusAPIClient {
    
    // MARK: Path Router
    let url: String? = "https://api.census.gov"
    let key = Constants.CENSUS_API_KEY
    
    // MARK: Request
    func sendAPIRequest() {
        guard let urlString = url
            else { print("ERROR: Unable to get url path for API call")
        }
        Alamofire.request(.GET, urlString, paramaters: [])
            .responseJSON { response in
                print(response.data)
                print(response.response)
        }
    }
    
}