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
    var store = DataStore.sharedInstance

    var location: String
    var scoreName: String
    var score: Int
    var originDataPoints: [String: String]?
    var comparisonDataPoints: [String : String]?
    var economicScore: String
    var transitScore: String
    var demographicScore: String
    var educationScore: String
    var economicScoreFactors = [String:Double]()
    
    init (location:String, originDataPoints: [String : String], comparisonDataPoints: [String : String]) {
        self.originDataPoints = originDataPoints
        self.comparisonDataPoints = comparisonDataPoints
        self.scoreName = ""
        self.score = 0
        self.economicScore = " "
        self.transitScore = " "
        self.demographicScore = " "
        self.educationScore = " "
        self.location = location 
        self.getTransitScore()
    }
    
    // MARK: - Origin should be the higher level - US -> State -> County -> City
    // MARK: - Otherwise it should just be the starting destination
    
    mutating func getEconomicScore() -> (String, [String:Double])  {
        
        // FIXME: - Figure this out
        guard let
            originMedianHouseIncome = Double(self.originDataPoints!["Median household income"]!),
            comparisonMedianHouseIncome = Double(self.comparisonDataPoints!["Median household income"]!),
            originPovertyLevel =  Double(self.comparisonDataPoints!["Below poverty level"]!),
            originUnemployed = Double(self.comparisonDataPoints!["Unemployed"]!)
            else {
                fatalError()
        }
    
        self.economicScoreFactors["Comparison Median household income"] = originMedianHouseIncome
        self.economicScoreFactors["Origin Median household income"] = originMedianHouseIncome
        self.economicScoreFactors["Origin Poverty level"] = originPovertyLevel
        self.economicScoreFactors["Comparison Poverty level"] = originPovertyLevel
        self.economicScoreFactors["Origin unemployed level"] = originUnemployed
        self.economicScoreFactors["Comparison unemployed level"] = originUnemployed
        
        
        // MARK: - Subtracts the comparison level with the origin level
        // MARK: - Should take the lowever level, for instance, and subtract by the higher level
        // MARK: - Ex. City Avg - US Avg which should produce a positive number
        
        let subtractedValueForPercentage = comparisonMedianHouseIncome - originMedianHouseIncome
        
        // MARK: - Takes the origin data and divides by the subtractedValue to get a percentage, then adds by 100
        
        let percentageChange = Int((originMedianHouseIncome/subtractedValueForPercentage) * 100.0)
        
       // MARK: - (String(percentageChange), eachScore)
        
        if comparisonMedianHouseIncome > originMedianHouseIncome {
            self.economicScore = "High"
            return ("High", self.economicScoreFactors)
        } else if comparisonMedianHouseIncome > originMedianHouseIncome && comparisonMedianHouseIncome < originMedianHouseIncome {
            self.economicScore = "Med."
            return ("Med.", self.economicScoreFactors)
        } else {
            self.economicScore = "Low"
            return ("Low", self.economicScoreFactors)
        }
    }

    mutating func getTransitScore() -> (String, [String:String]) {
        // TODO: - add method body
      
        guard let
            comparisonPoint = self.comparisonDataPoints,
            originPoints = self.originDataPoints,
            originCommute = originPoints["Average travel time to work one way in minutes"],
            compareCommute = comparisonPoint["Average travel time to work one way in minutes"]
            else {
                fatalError()
        }
        let transitArray = ["Origin Average travel time to work one way in minutes": originCommute, "Comparison Average travel time to work one way in minutes": compareCommute]
        
//       var total["Origin Average travel time to work one way in minutes": originCommute, "Comparison Average travel time to work one way in minutes": compareCommute]
    
       // var transitArray: (String, Double)
        //print("None")
        
        
        if compareCommute > originCommute {
            self.transitScore = "High"
            return ("High", transitArray)
        } else if compareCommute > originCommute && compareCommute < originCommute {
            self.transitScore = "Med."
            return ("Med.", transitArray)
        } else {
            self.transitScore = "Low"
            return ("Low", transitArray)
        }
    }
    
    mutating func getEducationScore() -> (String, [String:Double?], [String:Double?]) {
        // MARK: - Origin data points
        
        let originNoSchool = Double(self.originDataPoints!["No schooling completed"]!)
        let originHighSchool = Double(self.originDataPoints!["High school diploma"]!)
        let originGED = Double(self.originDataPoints!["GED or alternative credential"]!)
        let originProfessionalDegree = Double(self.originDataPoints!["Professional school degree"]!)
        let originBachelors = Double(self.originDataPoints!["Bachelor's degree"]!)
        let originMasters = Double(self.originDataPoints!["Master's degree"]!)
        let originDoctorates = Double(self.originDataPoints!["Doctorate degree"]!)
        
        let originEducation = ["No schooling completed": originNoSchool!, "High school diploma":originHighSchool,"GED or alternative credential":originGED, "Professional school degree": originProfessionalDegree, "Bachelor's degree":originBachelors,"Master's degree":originMasters, "Doctorate degree":originDoctorates]
        
        // MARK: - Comparisson data points
        let comparisonNoSchool = Double(self.comparisonDataPoints!["No schooling completed"]!)
        let comparisonHighSchool = Double(self.comparisonDataPoints!["High school diploma"]!)
        let comparisonGED = Double(self.comparisonDataPoints!["GED or alternative credential"]!)
        let comparisonProfessionalDegree = Double(self.comparisonDataPoints!["Professional school degree"]!)
        let comparisonBachelors = Double(self.comparisonDataPoints!["Bachelor's degree"]!)
        let comparisonMasters = Double(self.comparisonDataPoints!["Master's degree"]!)
        let comparisonDoctorates = Double(self.comparisonDataPoints!["Doctorate degree"]!)
        
        let comparisonEducation = ["No schooling completed": comparisonNoSchool!, "High school diploma":comparisonHighSchool,"GED or alternative credential": comparisonGED, "Professional school degree": comparisonProfessionalDegree, "Bachelor's degree":comparisonBachelors,"Master's degree":comparisonMasters, "Doctorate degree":comparisonDoctorates]
        
        let originValues = [originNoSchool!, originHighSchool!, originGED!, originProfessionalDegree!, originBachelors!, originMasters!, originDoctorates!]
        
        var originSum = 0.0
        for values in originValues {
            originSum += originSum + values
        }
        
        let comparisonValues = [comparisonNoSchool!, comparisonHighSchool!, comparisonGED!, comparisonProfessionalDegree!, comparisonBachelors!, comparisonMasters!, comparisonDoctorates!]
        
        
        var comparisonSum = 0.0
        for values in comparisonValues {
            comparisonSum += comparisonSum + values
        }
        
        let originDegreePercentage = ((originBachelors! + originMasters! + originDoctorates!)/originSum) * 100

        
        let comparisonDegreePercentage = ((comparisonBachelors! + comparisonMasters! + comparisonDoctorates!)/comparisonSum) * 100
        
   
        
        if comparisonDegreePercentage > originDegreePercentage * 2 {
            self.educationScore = "High"
            return ("High", originEducation, comparisonEducation)
        } else if comparisonDegreePercentage > originDegreePercentage && comparisonDegreePercentage < originDegreePercentage * 2 {
            self.educationScore = "Med"
            return ("Med.", originEducation, comparisonEducation)
        } else {
            self.educationScore = "Low"
            return ("Low", originEducation, comparisonEducation)
        }
    }
    mutating func getDemographicScore() -> (String, [String:String],[String:String]) {
            
            //MARK: - Origin Data Points
            let whiteOriginPercentage = self.originDataPoints!["White"]
            let blackOriginPercentage = self.originDataPoints!["Black or African American"]
            let americanIndianOriginPercentage = self.originDataPoints!["American Indian and Alaska Native"]
            let asianOriginPercentage = self.originDataPoints!["Asian"]
            let pacificIslanderOriginPercentage = self.originDataPoints!["Pacific islander"]
            let hispanicOriginPercentage = self.originDataPoints!["Hispanic or Latino"]
            
            let originDiversity = ["White": whiteOriginPercentage!, "Black or African American": blackOriginPercentage!, "American Indian and Alaska Native": americanIndianOriginPercentage!, "Asian":asianOriginPercentage!, "Pacific islander": pacificIslanderOriginPercentage!, "Hispanic or Latino": hispanicOriginPercentage!]
            
            
            let originAge = self.originDataPoints!["Age"]
            let comparisonAge = self.comparisonDataPoints!["Age"]
        
            // MARK: - Comparison Data Points
            let whiteComparisonPercentage = self.comparisonDataPoints!["White"]
            let blackComparisonPercentage = self.comparisonDataPoints!["Black or African American"]
            let americanIndianComparisonPercentage = self.comparisonDataPoints!["American Indian and Alaska Native"]
            let asianComparisonPercentage = self.comparisonDataPoints!["Asian"]
            let pacificIslanderComparisonPercentage = self.comparisonDataPoints!["Pacific islander"]
            let hispanicComparisonPercentage = self.comparisonDataPoints!["Hispanic or Latino"]
        
            let comparisonDiversity = ["White": whiteComparisonPercentage!, "Black or African American": blackComparisonPercentage!, "American Indian and Alaska Native": americanIndianOriginPercentage!, "Asian":asianOriginPercentage!, "Pacific islander": pacificIslanderComparisonPercentage!, "Hispanic or Latino": hispanicComparisonPercentage!]
            
            
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
        
            if comparisonSum > originSum * 2 {
                self.demographicScore = "High"
                return ("High", originDiversity, comparisonDiversity)
            } else if comparisonSum > originSum && comparisonSum < originSum * 2 {
                self.demographicScore = "Med."
                return ("Med.", originDiversity, comparisonDiversity)
            } else {
                self.demographicScore = "Low"
                return ("Low", originDiversity, comparisonDiversity)
            }
        }
    
    mutating func getScoresArray() -> [String] {
        self.getEducationScore()
        self.getTransitScore()
        self.getEconomicScore()
        let returnArray = [String(self.educationScore), String(self.transitScore), String(self.economicScore), String(self.demographicScore)]
        return returnArray
    }
    
    mutating func getAggregateScore() -> String {
        let ecoScore = self.getEconomicScore()
        let eduScore = self.getEducationScore()
        let tranScore = self.getTransitScore()
        let demScore = self.getDemographicScore()
        
        let scores = getScoresArray()[0]
        //var aggregateScore = 0
       // for score in scores {
          //  aggregateScore = aggregateScore + Int(score)!
       // }
       // aggregateScore = aggregateScore / scores.count
        return scores
    }
    
    
}
