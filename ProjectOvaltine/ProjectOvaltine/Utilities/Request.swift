//
//  Request.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol Request {
    var baseURL : String? { get }
    var path : String? { get }
    var parameters : Dictionary<String, String> { get }
}