//
//  CitySDKAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class CensusAPIClient: Request {
    
    // MARK: Path Router
    let baseURL: String? = "https://uscensusbureau.github.io/citysdk/"
    let method = .POST
    let path = "/"
    let paramaters = ["parameterOne": "not implemented"]
    let key = Constants.CITYSDK_API_KEY
    
    // MARK: Request
    func sendAPIRequest() {
        guard let urlString = self.baseURL + self.path
            else { print("ERROR: Unable to get url path for API call")
        }
        Alamofire.request(.GET, urlString, paramaters: [])
            .responseJSON { response in
                print(response.data)
                print(response.response)
        }
    }
    
}