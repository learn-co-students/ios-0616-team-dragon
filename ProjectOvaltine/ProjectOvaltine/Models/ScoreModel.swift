//
//  ScoreModel.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct ScoreModel {
    var scoreName: String
    var score:Int = 0
    var dataPoints: [String] = []
    
    init(name: String, dataPoints: [String]) {
        self.scoreName = name
    }
    
    
    func getEconomicScore() -> String {
        return "Finance Score"
    }
    
    func getTransitScore() -> String {
        return "Transit Score"
    }
    
    func getEducationScore() -> String {
        return "Education Score"
    }
    
    func getDemographicScore() -> String {
        return "Demographic Score"
    }
    
    
}
