//
//  Models.swift
//  ProjectOvaltine
//
//  Created by Max Tkach on 8/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


class CityModel {
    
    var name = ""
    var dataSets: [DataSetModel] = []
    
}


class USModel {
    
    var name = "Unites States"
    var dataSets: [DataSetModel] = []
    
}


class DataSetModel {
    
    var name = ""
    var type = ""
    var ratable = false
    var displayPercent = false
    var values: [DataSetValueModel] = []
    
}


class DataSetValueModel {
    
    var name = ""
    var absoluteValue = ""
    var percentValue = ""
    
}
