//
//  CitySDKData.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import SwiftyJSON

class CitySDKData {
    var latitude: String
    var longitude: String
    var state: String
    var income: Int
    var population: Int
    
    
    //Comment
    init?(json: JSON) {
        guard let
            lat = json["lat"].string,
            long = json["long"].string,
            state = json["state"].string,
            income = json["int"].int,
            pop = json["population"].int
            else { return nil }
        self.latitude = lat
        self.longitude = long
        self.state = state
        self.income = income
        self.population = pop
    }
}