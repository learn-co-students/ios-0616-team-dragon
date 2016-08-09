//
//  Request.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
//
//protocol Request {
//    //var baseURL: String { get }
//    var method: String { get }
//    var URLPath: String { get }
//    var parameters: Dictionary<String, String> { get }
//    var headers: Dictionary<String, String> { get }
//}
//
//extension Request {
//    var method : String { return "GET" }
//    var path : String { return "" }
//    var parameters : Dictionary<String, String> { return Dictionary() }
//}

//extension Request {
//    var method : String { return "GET" }
//    var path : String { return "" }
//    var parameters : Dictionary<String, String> { return Dictionary() }
//    var headers : Dictionary<String, String> { return Dictionary() }
//}
//
//
//extension Request {
//    func buildRequest() -> NSURLRequest? {
//        guard let baseURL = baseURL else { return nil }
//        guard let URLComponents = NSURLComponents(URL: baseURL, resolvingAgainstBaseURL: true) else { return nil }
//        URLComponents.path = (URLComponents.path ?? "") + path
//        guard let URL = URLComponents.URL else { return nil }
//        let request = NSMutableURLRequest(URL:URL)
//        request.HTTPMethod = method
//        return request
//    }
//    
//    func sendRequest(success success: (string: String) -> (), failure: (error: ErrorType) -> ()) {
//        let session = NSURLSession.sharedSession()
//        guard let request = buildRequest() else { return }
//        guard let task = session.dataTaskWithRequest(request, completionHandler: { (taskData, taskResponse, taskError) -> Void in
//            if let taskError = taskError {
//                failure (error: taskError)
//            } else if let taskData = taskData {
//                guard let string = NSString(data: taskData, encoding: NSUTF8StringEncoding) as? String else { return }
//                success(string: string)
//            }
//        }) else { return }
//        task.resume()
//    }

    
//    func sendRequest(success success: (string: String) -> (), failure: (error: ErrorType) -> ()) {
//        let session = NSURLSession.sharedSession()
//        guard let request = buildRequest() else { return }
//        
//        guard let task = session.dataTaskWithRequest(request, completionHandler: { (taskData, taskResponse, taskError) -> Void in
//        if let taskError = taskError {
//            failure(error: taskError)
//        } else if let taskData = taskData {
//        guard let string = NSString(data: taskData, encoding: NSUTF8StringEncoding) as? String else { return }
//                success(string:string)
//            }
//        }) else { return }
//        task.resume()
//    }

//protocol ConstructableRequest: Request {
//    func buildRequest() -> NSURLRequest?
//}
//
//protocol JSONConstructableRequest: ConstructableRequest { }
//extension JSONConstructableRequest {
//    func buildRequest() -> NSURLRequest? {
//        // build a URL for the request
//        // encode the parameters as JSON
//        // etc
//        // return the request
//    }
//}
//
//
//protocol SendableRequest: ConstructableRequest { }
//extension SendableRequest {
//    func sendRequest(success success: (string: String) -> (), failure: (error: ErrorType) -> ()) {
//        // send the request
//        // parse the result
//        // fire the blocks on success and failure
//    }
//}

//}