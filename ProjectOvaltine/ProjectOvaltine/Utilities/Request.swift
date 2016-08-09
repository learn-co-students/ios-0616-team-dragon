//
//  Request.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol Request {
    var baseURL: NSURL? { get }
    var method: String { get }
    var path: String { get }
    var parameters: Dictionary<String, String> { get }
    var headers: Dictionary<String, String> { get }
}

extension Request {
    var method : String { return "GET" }
    var path : String { return "" }
    var parameters : Dictionary<String, String> { return Dictionary() }
    var headers : Dictionary<String, String> { return Dictionary() }
}

protocol ConstructableRequest: Request {
    func buildRequest() -> NSURLRequest?
}

protocol JSONConstructableRequest: ConstructableRequest { }
extension JSONConstructableRequest {
    func buildRequest() -> NSURLRequest? {
        // build a URL for the request
        // encode the parameters as JSON
        // etc
        // return the request
    }
}


protocol SendableRequest: ConstructableRequest { }
extension SendableRequest {
    func sendRequest(success success: (string: String) -> (), failure: (error: ErrorType) -> ()) {
        // send the request
        // parse the result
        // fire the blocks on success and failure
    }
}