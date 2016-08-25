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
    var location: String
    var scoreName: String
    var score: Int
    var originDataPoints: [String: String]?
    var comparisonDataPoints: [String : String]?
    var economicScore: Int
    var transitScore: Int
    var demographicScore: Int
    var educationScore: Int
    var economicScoreFactors = [String:Double]()
    
    init (location:String, originDataPoints: [String : String], comparisonDataPoints: [String : String]) {
        self.originDataPoints = originDataPoints
        //print("Origin \(originDataPoints["Median gross rent as percentage of household income"])")
        //print("\(originDataPoints)\n\n\n\n\n\n\n\n\n\n\n\n")
        self.comparisonDataPoints = comparisonDataPoints
        //print("Comparison \(comparisonDataPoints)\n\n\n\n\n\n\n\n\n\n")
        self.scoreName = ""
        self.score = 0
        self.economicScore = 0
        self.transitScore = 0
        self.demographicScore = 0
        self.educationScore = 0
        self.location = location 
        self.getTransitScore()
    }
    
    // MARK: - Origin should be the higher level - US -> State -> County -> City
    // MARK: - Otherwise it should just be the starting destination
    
    //mutating func getEconomicScore() -> (String, (Double, Double)) {
    
    mutating func getEconomicScore() -> String {
        
        // FIXME: - Figure this out
        
        let origin = Double(self.originDataPoints!["Median household income"]!)
        let comparison = Double(self.comparisonDataPoints!["Median household income"]!)
        self.economicScoreFactors["Comparison - Median household income"] = comparison
        self.economicScoreFactors["Origin - Median household income"] = origin
        
        // MARK: - Subtracts the comparison level with the origin level
        // MARK: - Should take the lowever level, for instance, and subtract by the higher level
        // MARK: - Ex. City Avg - US Avg which should produce a positive number
        
        //print("Origin: \(origin)")
        //print("Comparison: \(comparison)")
        
        print(self.economicScoreFactors)
        
        let subtractedValueForPercentage = comparison! - origin!
        
        // MARK: - Takes the origin data and divides by the subtractedValue to get a percentage, then adds by 100
        
        let percentageChange = Int((origin!/subtractedValueForPercentage) * 100.0)
        
        print(percentageChange)
        
        guard let
            unwrappedOrigin = origin,
            unrappedComparison = comparison
            else {
                fatalError()
        }
        
        let eachScore = (unwrappedOrigin, unrappedComparison)
        
        
        
       // MARK: - (String(percentageChange), eachScore)
        
        if comparison > origin {
            print("High")
            return "High"
        } else if comparison > origin && comparison < origin {
            print("Med")
            return "Med."
        } else {
            print("Low")
            return "Low"
        }
    }
    
    mutating func getTransitScore() -> String {
        // TODO: - add method body
        //
        let originCommuteTime = Double(self.originDataPoints!["Average travel time to work one way in minutes"]!)
        let comparisonCommuteTime = Double(self.comparisonDataPoints!["Average travel time to work one way in minutes"]!)
        //print("None")
        if comparisonCommuteTime > originCommuteTime {
            print("High")
            return "High"
        } else if comparisonCommuteTime > originCommuteTime && comparisonCommuteTime < originCommuteTime {
            print("Med")
            return "Med."
        } else {
            print("Low")
            return "Low"
        }
        
        ///return String(self.originDataPoints!["Average travel time to work one way in minutes"])
    }
    
    mutating func getEducationScore() -> String {
        // MARK: - Origin data points
        
        let originNoSchool = Double(self.originDataPoints!["No schooling completed"]!)
        let originHighSchool = Double(self.originDataPoints!["High school diploma"]!)
        let originGED = Double(self.originDataPoints!["GED or alternative credential"]!)
        let originProfessionalDegree = Double(self.originDataPoints!["Professional school degree"]!)
        let originBachelors = Double(self.originDataPoints!["Bachelor's degree"]!)
        let originMasters = Double(self.originDataPoints!["Master's degree"]!)
        let originDoctorates = Double(self.originDataPoints!["Doctorate degree"]!)
        
        // MARK: - Comparisson data points
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
        
        
        var comparisonSum = 0.0
        for values in comparisonValues {
            comparisonSum += comparisonSum + values!
        }
        
        let originDegreePercentage = ((originBachelors! + originMasters! + originDoctorates!)/originSum) * 100

        
        let comparisonDegreePercentage = ((comparisonBachelors! + comparisonMasters! + comparisonDoctorates!)/comparisonSum) * 100
        
   
        
        if comparisonDegreePercentage > originDegreePercentage * 2 {
            return "High"
        } else if comparisonDegreePercentage > originDegreePercentage && comparisonDegreePercentage < originDegreePercentage * 2 { return "Med." } else { return "Low" }
        
    }
    
        mutating func getDemographicScore() -> String {
            
            //MARK: - Origin Data Points
            let whiteOriginPercentage = self.originDataPoints!["White"]
            let blackOriginPercentage = self.originDataPoints!["Black or African American"]
            let americanIndianOriginPercentage = self.originDataPoints!["American Indian and Alaska Native"]
            let asianOriginPercentage = self.originDataPoints!["Asian"]
            let pacificIslanderOriginPercentage = self.originDataPoints!["Pacific islander"]
            let hispanicOriginPercentage = self.originDataPoints!["Hispanic or Latino"]
            
            // MARK: - Comparison Data Points
            let whiteComparisonPercentage = self.comparisonDataPoints!["White"]
            let blackComparisonPercentage = self.comparisonDataPoints!["Black or African American"]
            let americanIndianComparisonPercentage = self.comparisonDataPoints!["American Indian and Alaska Native"]
            let asianComparisonPercentage = self.comparisonDataPoints!["Asian"]
            let pacificIslanderComparisonPercentage = self.comparisonDataPoints!["Pacific islander"]
            let hispanicComparisonPercentage = self.comparisonDataPoints!["Hispanic or Latino"]
            
            let originArray = [whiteOriginPercentage!, blackOriginPercentage!, americanIndianOriginPercentage!, asianOriginPercentage!, pacificIslanderOriginPercentage!, hispanicOriginPercentage!]
            
            let comparisonArray = [whiteComparisonPercentage!, blackComparisonPercentage!, americanIndianComparisonPercentage!, asianComparisonPercentage!, pacificIslanderComparisonPercentage!, hispanicComparisonPercentage!]
            
            var comparisonSum = 0.0
            for values in comparisonArray {
                comparisonSum += comparisonSum + Double(values)!
            }
            
            var originSum = 0.0
            for values in originArray {
                originSum += originSum + Double(values)!
            }
            
            print(originArray)
            
            if comparisonSum > originSum * 2 {
                return "High"
            } else if comparisonSum > originSum && comparisonSum < originSum * 2 {
                return "Med."
            } else {
                return "Low"
            }
            
//            print("\n\n\n\n\n DEMOGRAPHICS  \(comparisonArray)")
//            print("\n\n\n\n\n\n\n DEMOG \(originArray)")
//            
//            let returnValue = ""
//            return returnValue
        }
    
    mutating func getScoresArray() -> [String] {
        self.getEducationScore()
        self.getTransitScore()
        self.getEconomicScore()
        // self.getDemographicScore()
        print(getTransitScore())
        let returnArray = [String(self.educationScore), String(self.transitScore), String(self.economicScore), String(self.demographicScore)]
        return returnArray
    }
    

    mutating func getEconomicScoreBreakDown() {
        
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
