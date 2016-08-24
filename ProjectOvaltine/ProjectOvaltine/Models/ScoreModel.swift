//
//  ScoreModel.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct ScoreModel {
    // MARK: - Properties 
    
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
        // FIXME: Figure this out
        print("Inside getEconomicScore")
        
        let origin = Double(self.originDataPoints!["Median household income"]!)
        let comparison = Double(self.comparisonDataPoints!["Median household income"]!)
        
        
        //        Subtracts the comparison level with the origin level
        //            Should take the lowever level, for instance, and subtract by the higher level
        //            Ex. City Avg - US Avg which should produce a positive number
        
        
        
        let subtractedValueForPercentage = comparison! - origin!
        
        //        Takes the origin data and divides by the subtractedValue to get a percentage, then adds by 100
        let percentageChange = ((origin!/subtractedValueForPercentage) * 100.0)
        
        
        return String(percentageChange)
    }
    
    mutating func getTransitScore() -> String {
        // TODO: add method body 
        
        
        //let origin = Double(self.originDataPoints!["Average travel time to work one way in minutes"]!)
        // let comparison = Double(self.comparisonDataPoints!["Average travel time to work one way in minutes"]!)
        
        return ""
    }
    
    mutating func getEducationScore() -> String {
        print("INSIDE getEducationScore")
        //Origin data points
        
        let originNoSchool = Double(self.originDataPoints!["No schooling completed"]!)
        let originHighSchool = Double(self.originDataPoints!["High school diploma"]!)
        let originGED = Double(self.originDataPoints!["GED or alternative credential"]!)
        let originProfessionalDegree = Double(self.originDataPoints!["Professional school degree"]!)
        let originBachelors = Double(self.originDataPoints!["Bachelor's degree"]!)
        let originMasters = Double(self.originDataPoints!["Master's degree"]!)
        let originDoctorates = Double(self.originDataPoints!["Doctorate degree"]!)
        
        //Comparisson data points
        let comparisonNoSchool = Double(self.comparisonDataPoints!["No schooling completed"]!)
        let comparisonHighSchool = Double(self.comparisonDataPoints!["High school diploma"]!)
        let comparisonGED = Double(self.comparisonDataPoints!["GED or alternative credential"]!)
        let comparisonProfessionalDegree = Double(self.comparisonDataPoints!["Professional school degree"]!)
        let comparisonBachelors = Double(self.comparisonDataPoints!["Bachelor's degree"]!)
        let comparisonMasters = Double(self.comparisonDataPoints!["Master's degree"]!)
        let comparisonDoctorates = Double(self.comparisonDataPoints!["Doctorate degree"]!)
        
        //        [ x1, x2, ... , xn].map(f) -> [f(x1), f(x2), ... , f(xn)]
        
        let originValues = [originNoSchool, originHighSchool, originGED, originProfessionalDegree, originBachelors, originMasters, originDoctorates]
        
        var originSum = 0.0
        for values in originValues {
            originSum += originSum + values!
        }
        
        let comparisonValues = [comparisonNoSchool, comparisonHighSchool, comparisonGED, comparisonProfessionalDegree, comparisonBachelors, comparisonMasters, comparisonDoctorates]
        
        print(comparisonValues.enumerate())
        
        var comparisonSum = 0.0
        for values in comparisonValues {
            comparisonSum += comparisonSum + values!
        }
        
        let originDegreePercentage = ((originBachelors! + originMasters! + originDoctorates!)/originSum) * 100
        print("originDegreePercentage \(originDegreePercentage)")
        
        let comparisonDegreePercentage = ((comparisonBachelors! + comparisonMasters! + comparisonDoctorates!)/comparisonSum) * 100
        
        print("originDegreePercentage \(comparisonDegreePercentage)")
        
        if comparisonDegreePercentage > originDegreePercentage * 2 {
            return "High"
        } else if comparisonDegreePercentage > originDegreePercentage && comparisonDegreePercentage < originDegreePercentage * 2 { return "Moderate" } else { return "Low" }
        
    }
    
    mutating func getDemographicScore() -> String {
        print("inside get demographic score")
        var returnValue = ""
        return returnValue
    }
    
    mutating func getScoresArray() -> [String] {
        self.getEducationScore()
        self.getTransitScore()
        self.getEconomicScore()
        // self.getDemographicScore()
        let returnArray = [String(self.educationScore), String(self.transitScore), String(self.economicScore), String(self.demographicScore)]
        return returnArray
    }
    
    mutating func getAggregateScore() -> String {
        let scores = getScoresArray()
        var aggregateScore = 0
        for score in scores {
            aggregateScore = aggregateScore + Int(score)!
        }
        aggregateScore = aggregateScore / scores.count
        return String(aggregateScore)
    }
    
    
}
