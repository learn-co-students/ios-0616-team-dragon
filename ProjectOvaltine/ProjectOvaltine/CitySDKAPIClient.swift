//
//  CitySDKAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class CitySDKAPIClient {
    // MARK: Path Router
    let url: String? = "" 
    let key = Constants.CITYSDK_API_KEY
    
    // MARK: Request
    func sendAPIRequest() -> [CitySDKData] {
        guard let urlString = url
            else {
                print("ERROR: Unable to get url path for starred status")
                return [CitySDKData(json:["not":"implemented"])!]
        }
        
        return [CitySDKData(json:["not":"implemented"])!]
    }

    
}
