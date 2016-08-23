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
        
        
        let origin = Double(self.originDataPoints!["Median household income"]!)
        let comparison = Double(self.comparisonDataPoints!["Median household income"]!)
        
        
        
        //        Subtracts the comparison level with the origin level
        //            Should take the lowever level, for instance, and subtract by the higher level
        //            Ex. City Avg - US Avg which should produce a positive number
        let subtractedValueForPercentage = comparison! - origin!
        
        //        Takes the origin data and divides by the subtractedValue to get a percentage, then adds by 100
        let percentageChange = ((origin!/subtractedValueForPercentage) * 100.0)
        
        print(percentageChange)
        
        
        
        return String(percentageChange)
    }
    
    mutating func getTransitScore() -> String {
        
        let origin = Double(self.originDataPoints!["Average travel time to work one way in minutes"]!)
        let comparison = Double(self.comparisonDataPoints!["Average travel time to work one way in minutes"]!)
        
        
        print(origin)
        print(comparison)
        //        Subtracts the comparison level with the origin level
        //            Should take the lowever level, for instance, and subtract by the higher level
        //            Ex. City Avg - US Avg which should produce a positive number
        //let subtractedValueForPercentage = comparison? - origin?
        
        //        Takes the origin data and divides by the subtractedValue to get a percentage, then adds by 100
        // let percentageChange = ((origin!/subtractedValueForPercentage) * 100.0)
        
        //    print(percentageChange)
        
        
        
        //return String(percentageChange)
        
        return ""
    }
    //
    mutating func getEducationScore() -> String {
        
//        "002E": "No schooling completed",
//        "017E": "High school diploma",
//        "018E": "GED or alternative credential",
//        "024E": "Professional school degree",
//        "022E": "Bachelor's degree",
//        "023E": "Master's degree",
//        "025E": "Doctorate degree",
        
        //Origin data points
        let originNoSchool = Int(self.originDataPoints!["No schooling completed"]!)
        let originHighSchool = Int(self.originDataPoints!["High school diploma"]!)
        let originGED = Int(self.originDataPoints!["GED or alternative credential"]!)
        let originProfessionalDegree = Int(self.originDataPoints!["Professional school degree"]!)
        let originBachelors = Int(self.originDataPoints!["Bachelor's degree"]!)
        let originMasters = Int(self.originDataPoints!["Master's degree"]!)
        let originDoctorates = Int(self.originDataPoints!["Doctorate degree"]!)
        
        //Comparisson data points
        let comparisonNoSchool = Int(self.comparisonDataPoints!["No schooling completed"]!)
        let comparisonHighSchool = Int(self.comparisonDataPoints!["High school diploma"]!)
        let comparisonGED = Int(self.comparisonDataPoints!["GED or alternative credential"]!)
        let comparisonProfessionalDegree = Int(self.comparisonDataPoints!["Professional school degree"]!)
        let comparisonBachelors = Int(self.comparisonDataPoints!["Bachelor's degree"]!)
        let comparisonMasters = Int(self.comparisonDataPoints!["Master's degree"]!)
        let comparisonDoctorates = Int(self.comparisonDataPoints!["Doctorate degree"]!)
        
//        [ x1, x2, ... , xn].map(f) -> [f(x1), f(x2), ... , f(xn)]
        
        let originValues = [originNoSchool, originHighSchool, originGED, originProfessionalDegree, originBachelors, originMasters, originDoctorates]
        
        let totalOriginValues = originValues.map{$0! + $0!}
        
        print(totalOriginValues)
        
        let comparisonValues = [comparisonNoSchool, comparisonHighSchool, comparisonGED, comparisonProfessionalDegree, comparisonBachelors, comparisonMasters, comparisonDoctorates]
        
        let totalComparisonValues = comparisonValues.map{$0! + $0!}
        
        print(totalComparisonValues)
        
        //        Takes the origin data and divides by the subtractedValue to get a percentage, then adds by 100
        //let percentageChange = ((origin!/subtractedValueForPercentage) * 100.0)
        
//        print(percentageChange)
//        
//        return String(percentageChange)
        return ""
    }
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
