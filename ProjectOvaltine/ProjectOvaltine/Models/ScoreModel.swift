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
    var dataPoints: [String: String]
    var economicScore: Int
    var transitScore: Int
    var demographicScore: Int
    var educationScore: Int
    
    init(name: String, dataPoints: [String: String]) {
        self.scoreName = name
        self.dataPoints = dataPoints
        self.score = 0
        self.economicScore = 0
        self.transitScore = 0
        self.demographicScore = 0
        self.educationScore = 0
    }
    
    
    func getEconomicScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            sum = sum + Int(data)!
        }
        returnValue = String(sum)
        return "Economic Score \(returnValue)"
    }
    
    func getTransitScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            sum = sum + Int(data)!
        }
        returnValue = String(sum)
        return "Transit Score \(returnValue)"
    }
    
    func getEducationScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            sum = sum + Int(data)!
        }
        returnValue = String(sum)
        return "Education Score \(returnValue)"
    }
    
    func getDemographicScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            sum = sum + Int(data)!
        }
        returnValue = String(sum)
        return "Demographic Score \(returnValue)"
    }
    
    
}
