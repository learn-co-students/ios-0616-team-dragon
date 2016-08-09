//
//  CityAPIClientStruct.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/9/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


protocol MethodRouter {
    var method: String { get }
}

enum MethodType: MethodRouter {
    case GET, POST
    var method: String {
        switch self {
        case POST: return "POST"
        case GET: return "GET"
        }
    }
}


protocol Request {
    var method: String { get }
    var baseURL: NSURL? { get }
    var URLPath: String { get }
    var parameters: Dictionary<String, String> { get }
    var headers: Dictionary<String, String> { get }
}


extension Request {
    var method : String { return "GET" }
    var path : String { return "" }
    var parameters : Dictionary<String, String> { return Dictionary() }
    var headers: Dictionary<String, String> { return Dictionary() }
}

extension Request {
    func buildRequest() -> NSURLRequest? {
        guard let baseURL = baseURL else { return nil }
        guard let URLComponents = NSURLComponents(URL: baseURL, resolvingAgainstBaseURL: true) else { return nil }
        
        URLComponents.path = (URLComponents.path ?? "") + path
        guard let URL = URLComponents.URL else { return nil }
        let request = NSMutableURLRequest(URL:URL)
        request.HTTPMethod = method
        return request
    }
}

struct NewRequest : Request {
    let method: String = MethodType.GET.method
    let baseURL: NSURL? = NSURL(string:"baseURL.com")
    let URLPath: String = "URLPATH"
    
}

//    enum URLRouter: Request {
////      static let baseURL: String = "https://citySDK.github.io"
//        static let method: String = "GET"
//        static let URLPath: String = "/?"
//        static let parameters: Dictionary<String, String> = ["Not": "Implemented"]
//        static let headers: Dictionary<String, String> = ["Not": "Implemented"]
//    }
    
//    private static func sendAPIRequest(url: NSURL, params: NSDictionary, completion: ([CitySDKData]) -> ()) {
//        let headers = ["Authentication": "Basic \(Constants.CITYSDK_API_KEY)"]
//        let request = NSMutableURLRequest(URL:url)
//        request.HTTPMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(headers["Authentication"], forHTTPHeaderField: "Authorization")
//        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
//    }

