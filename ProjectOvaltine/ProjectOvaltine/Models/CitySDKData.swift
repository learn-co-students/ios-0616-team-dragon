//
//  CitySDKData.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/7/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import SwiftyJSON

class CitySDKData {
    var coordinates: NSArray
    init(json:JSON, geoJSON:NSArray) {
        self.coordinates = geoJSON
    }
}