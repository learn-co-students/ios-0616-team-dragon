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
    var score: Int
    var dataPoints: [String]
    var economicScore: Int
    var transitScore: Int
    var demographicScore: Int
    var educationScore: Int
    
    init(name: String, dataPoints: [String]) {
        self.scoreName = name
        self.dataPoints = dataPoints
        self.score = 0
        self.economicScore = 0
        self.transitScore = 0
        self.demographicScore = 0
        self.educationScore = 0 
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
