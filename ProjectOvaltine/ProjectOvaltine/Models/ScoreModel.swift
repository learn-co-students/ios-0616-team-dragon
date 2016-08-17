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
        print(self.getScoresDictionary())
    }
    
    mutating func getEconomicScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            if let data = Int(data) {
                sum = sum + data
            }
        }
        self.economicScore = sum / self.dataPoints.count
        returnValue = String(sum)
        return returnValue
    }
    
    mutating func getTransitScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            if let data = Int(data) {
                sum = sum + data
            }
        }
        self.transitScore = sum / self.dataPoints.count
        returnValue = String(sum)
        return returnValue
    }
    
    mutating func getEducationScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            if let data = Int(data) {
                sum = sum + data
            }
            
        }
        self.educationScore = sum / (self.dataPoints.count * 10)
        returnValue = String(sum)
        return returnValue
    }
    
    mutating func getDemographicScore() -> String {
        var returnValue = " "
        var sum = 0
        for data in self.dataPoints.values {
            if let data = Int(data) {
                sum = sum + data
            }
            
        }
        self.demographicScore = sum / self.dataPoints.count
        returnValue = String(sum)
        return returnValue
    }
    
    mutating func getScoresDictionary() -> [String: String] {
        self.getEducationScore()
        let returnDict = ["Education": String(self.educationScore), "Transit": self.getTransitScore(), "Economic": self.getEconomicScore(), "Demographic": getDemographicScore()]
        return returnDict
    }
    
    mutating func getAggregateScore() -> String {
        let scores = getScoresDictionary()
        var aggregateScore = 0
        for score in scores.values {
            aggregateScore = aggregateScore + Int(score)!
        }
        aggregateScore = aggregateScore / scores.values.count
        return String(aggregateScore)
    }
    
    
}
