//
//  CensusAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/9/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct CensusAPIClient: Request {
    var method: String = MethodRouter.GET.method
    var baseURLString: String = "http://api.census.gov/data/2014/"
    var URLPath: String = "acs5?get="
    var parameters: Dictionary<String, String> = Dictionary()
    var headers: Dictionary<String, String> = Dictionary()
    
    func buildRequest() -> NSURLRequest? {
        let zip = "10004"
        let urlZipPath = "&for=zip+code+tabulation+area:\(zip)"
        var paramString = ""
        
        for param in CensusConstants.CENSUS_REQUEST_PARAMS.values {
            if param.containsString(CensusConstants.CENSUS_REQUEST_PARAMS.values.first!) {
                paramString = param
            } else {
                paramString = "\(paramString),\(param)"
            }
        }
        let URLRequestPath = URLPath + paramString + urlZipPath
        guard let baseURL = NSURL(string:self.baseURLString + URLRequestPath) else { return nil }
        guard let URLComponents = NSURLComponents(URL:baseURL, resolvingAgainstBaseURL: true) else { return nil }
        guard let URL = URLComponents.URL else { return nil }
        let request = NSMutableURLRequest(URL:URL)
        request.HTTPMethod = method
        return request
    }
    
    func sendAPIRequest(request: NSURLRequest) {
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .Success(let responseObject):
                print(responseObject)
            default:
                print("ERROR")
            }
        }
    }
}