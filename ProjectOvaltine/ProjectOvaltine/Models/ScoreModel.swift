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
    var originDataPoints: [String: String]?
    var comparisonDataPoints: [String : String]?
    var economicScore: Int
    var transitScore: Int
    var demographicScore: Int
    var educationScore: Int
    
    init (originDataPoints: [String : String], comparisonDataPoints: [String : String]) {
        self.originDataPoints = originDataPoints
        self.comparisonDataPoints = comparisonDataPoints
        self.scoreName = ""
        self.score = 0
        self.economicScore = 0
        self.transitScore = 0
        self.demographicScore = 0
        self.educationScore = 0
    
    
    }
    
    //Origin should be the higher level - US -> State -> County -> City
        //Otherwise it should just be the starting destination
    mutating func getEconomicScore() -> String {
        var returnValue = ""
        var sumDifference = 0
        
        let origin = Double(self.originDataPoints!["Median household income"]!)
        let comparison = Double(self.comparisonDataPoints!["Median household income"]!)
        
  
        
        //Subtracts the comparison level with the origin level 
            //Should take the lowever level, for instance, and subtract by the higher level
            //Ex. City Avg - US Avg which should produce a positive number
        let subtractedValueForPercentage = comparison! - origin!
        
        //Takes the origin data and divides by the subtractedValue to get a percentage, then adds by 100
        let percentageChange = ((origin!/subtractedValueForPercentage) * 100.0)
        
        print(percentageChange)
        
        return ""
    }
//
//    mutating func getTransitScore() -> String {
//        var returnValue = " "
//        var sum = 0
//        for data in self.dataPoints!.values {
//            if let data = Int(data) {
//                sum = sum + data
//            }
//        }
//        self.transitScore = sum / self.dataPoints!.count
//        returnValue = String(sum)
//        return returnValue
//    }
//    
//    mutating func getEducationScore() -> String {
//        var returnValue = " "
//        var sum = 0
//        for data in self.dataPoints!.values {
//            if let data = Int(data) {
//                sum = sum + data
//            }
//            
//        }
//        self.educationScore = sum / (self.dataPoints!.count * 10)
//        returnValue = String(sum)
//        return returnValue
//    }
//    
//    mutating func getDemographicScore() -> String {
//        var returnValue = " "
//        var sum = 0
//        for data in self.dataPoints!.values {
//            if let data = Int(data) {
//                sum = sum + data
//            }
//            
//        }
//        self.demographicScore = sum / self.dataPoints!.count
//        returnValue = String(sum)
//        return returnValue
//    }
    
    mutating func getScoresDictionary() -> [String: String] {
       // self.getEducationScore()
       // self.getTransitScore()
        self.getEconomicScore()
       // self.getDemographicScore()
        let returnDict = ["Education": String(self.educationScore), "Transit": String(self.transitScore), "Economic": String(self.economicScore), "Demographic": String(self.demographicScore)]
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
