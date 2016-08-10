//
//  Request.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol MethodRouterType {
    var method: String { get }
}

enum MethodRouter: MethodRouterType {
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
    var baseURLString: String { get }
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
        guard let baseURL = NSURL(string:baseURLString + URLPath) else { return nil }
        guard let URLComponents = NSURLComponents(URL: baseURL, resolvingAgainstBaseURL: true) else { return nil }
        guard let URL = URLComponents.URL else { return nil }
        let request = NSMutableURLRequest(URL:URL)
        request.HTTPMethod = method
        return request
    }
}