//
//  Scoring.swift
//  ProjectOvaltine
//
//  Created by Max Tkach on 8/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


class ScoreCalculator {
    
    private var store = DataStore.sharedInstance
    
    var cityDataSets: [DataSetModel]
    var usDataSets: [DataSetModel]

    required init() {
        cityDataSets = []
        usDataSets = []
        cityDataSets = self.tabSets(city: true)
        usDataSets = self.tabSets(city: false)
    }
    
    
    private func tabSets(city city: Bool) -> [DataSetModel] {
        var sets: [DataSetModel] = []
        
        if city {
            sets = store.cityModel.dataSets.filter({ (dataSet) -> Bool in
                dataSet.ratable
            })
        } else {
            sets = store.usModel.dataSets.filter({ (dataSet) -> Bool in
                dataSet.ratable
            })
        }
        
        for set in sets {
            for (index, value) in set.values.enumerate() {
                if value.name == Hints.total {
                    set.values.removeAtIndex(index)
                }
            }
        }
        for set in sets {
            set.values.sortInPlace({ (valueModel1, valueModel2) -> Bool in
                valueModel1.name < valueModel2.name
            })
        }
        return sets.sort({ (dataSetModel1, dataSetModel2) -> Bool in
            dataSetModel1.name < dataSetModel2.name
        })
    }
    
    
    func createRatings() {
        
        self.store.cityScoresByDataSet.removeAll()
        self.store.cityScoresByType.removeAll()
        
        var econScores: [Double] = []
        var typeScores: [Double] = []
        
        for (dataSetIndex, dataSet) in self.cityDataSets.enumerate() {
            
            switch dataSet.name {
            
            case CensusAPIProperties.eduTransProperties["B08136"]![Hints.description]!: // Travel time to work
                let cityScore = dataSet.values[0].absoluteValue
                let usScore = self.usDataSets[dataSetIndex].values[0].absoluteValue
                let score = self.calculateScore(cityScore: cityScore, usScore: usScore, reversed: true)
                self.store.cityScoresByDataSet[dataSet.name] = score
                self.store.cityScoresByType[dataSet.type] = score
                
                if let actualScore = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
                    let reversedScore = 1 / actualScore
                    typeScores.append(reversedScore)
                }
            
                
            case CensusAPIProperties.eduTransProperties["B15003"]![Hints.description]!: // Education level
                var cityEdu: [String] = []
                var usEdu: [String] = []
                
                for (valueIndex, dataSetValue) in dataSet.values.enumerate() {
                    let property = CensusAPIProperties.eduTransProperties["B15003"]!
                    if dataSetValue.name == property["017E"] ||
                       dataSetValue.name == property["022E"] ||
                       dataSetValue.name == property["023E"] ||
                       dataSetValue.name == property["024E"] ||
                       dataSetValue.name == property["025E"] {
                        cityEdu.append(dataSetValue.percentValue)
                        usEdu.append(self.usDataSets[dataSetIndex].values[valueIndex].percentValue)
                    }
                }
                
                let cityScore = self.averageValueInArray(cityEdu)
                let usScore = self.averageValueInArray(usEdu)
                let score = self.calculateScore(cityScore: cityScore, usScore: usScore, reversed: false)
                self.store.cityScoresByDataSet[dataSet.name] = score
                self.store.cityScoresByType[dataSet.type] = score
                
                if let actualScore = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
                    typeScores.append(actualScore)
                }

                
            case CensusAPIProperties.demoProperties["B03002"]![Hints.description]!: // Diversity
                var cityEdu: [String] = []
                var usEdu: [String] = []
                
                for (valueIndex, dataSetValue) in dataSet.values.enumerate() {
                    let property = CensusAPIProperties.demoProperties["B03002"]!
                    if dataSetValue.name == property["004E"] ||
                        dataSetValue.name == property["005E"] ||
                        dataSetValue.name == property["006E"] ||
                        dataSetValue.name == property["007E"] ||
                        dataSetValue.name == property["012E"] {
                        cityEdu.append(dataSetValue.percentValue)
                        usEdu.append(self.usDataSets[dataSetIndex].values[valueIndex].percentValue)
                    }
                }
                
                let cityScore = self.averageValueInArray(cityEdu)
                let usScore = self.averageValueInArray(usEdu)
                let score = self.calculateScore(cityScore: cityScore, usScore: usScore, reversed: false)
                self.store.cityScoresByDataSet[dataSet.name] = score
                self.store.cityScoresByType[dataSet.type] = score
                
                if let actualScore = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
                    typeScores.append(actualScore)
                }
                
            
            case CensusAPIProperties.econProperties["B19013"]![Hints.description]!: // Median household income
                let cityScore = dataSet.values[0].absoluteValue
                let usScore = self.usDataSets[dataSetIndex].values[0].absoluteValue
                let score = self.calculateScore(cityScore: cityScore, usScore: usScore, reversed: false)
                self.store.cityScoresByDataSet[dataSet.name] = score
                
                if let actualScore = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
                    econScores.append(actualScore)
                }
                
            
            case CensusAPIProperties.econProperties["B25077"]![Hints.description]!: // Median house value
                let cityScore = dataSet.values[0].absoluteValue
                let usScore = self.usDataSets[dataSetIndex].values[0].absoluteValue
                let score = self.calculateScore(cityScore: cityScore, usScore: usScore, reversed: true)
                self.store.cityScoresByDataSet[dataSet.name] = score
                
                if let actualScore = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
                    let reversedScore = 1 / actualScore
                    econScores.append(reversedScore)
                }
            
                
            case CensusAPIProperties.econProperties["B23025"]![Hints.description]!: // Employment
                var cityScore = ""
                var usScore = ""
                
                for (index, value) in dataSet.values.enumerate() {
                    let property = CensusAPIProperties.econProperties["B23025"]!
                    if value.name == property["005E"] {
                        cityScore = value.percentValue
                        usScore = usDataSets[dataSetIndex].values[index].percentValue
                    }
                }

                let score = self.calculateScore(cityScore: cityScore, usScore: usScore, reversed: true)
                self.store.cityScoresByDataSet[dataSet.name] = score
                
                if let actualScore = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
                    let reversedScore = 1 / actualScore
                    econScores.append(reversedScore)
                }
                
                
            case CensusAPIProperties.econProperties["B17001"]![Hints.description]!: // Poverty level
                var cityScore = ""
                var usScore = ""
                
                for (index, value) in dataSet.values.enumerate() {
                    let property = CensusAPIProperties.econProperties["B17001"]!
                    if value.name == property["002E"] {
                        cityScore = value.percentValue
                        usScore = usDataSets[dataSetIndex].values[index].percentValue
                    }
                }
                
                let score = self.calculateScore(cityScore: cityScore, usScore: usScore, reversed: true)
                self.store.cityScoresByDataSet[dataSet.name] = score
                
                if let actualScore = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
                    let reversedScore = 1 / actualScore
                    econScores.append(reversedScore)
                }
            
            
            default:
                print("Data set < \(dataSet.name) > is not accounted for!")
            }
        }
        
        let averageEconScore = econScores.reduce(0, combine: +) / Double(econScores.count)
        typeScores.append(averageEconScore)
        
        let averageEconScoreName = self.scoreName(averageEconScore, reversed: false)
        self.store.cityScoresByType[Hints.economy] = averageEconScoreName
        
        let averageAbsoluteScore = typeScores.reduce(0, combine: +) / Double(typeScores.count)
        let averageAbsoluteScoreName = self.scoreName(averageAbsoluteScore, reversed: false)
        self.store.cityScoresByType[Hints.absolute] = averageAbsoluteScoreName
        
    }
    
    
    private func averageValueInArray(array: [String]) -> String {
        var totalValue = 0.0
        var totalElements = array.count
        
        for element in array {
            let elementNoPercent = self.cutPercent(element)
            if let elementDoubleValue = Double(elementNoPercent) {
                totalValue += elementDoubleValue
            } else {
                totalElements -= 1
            }
        }
        
        if totalElements > 0 {
            let averageDouble = totalValue / Double(totalElements)
            let averageInt = Int(averageDouble)
            let averageString = String(averageInt)
            return averageString
        } else {
            return "N/A"
        }
    }
    
    
    private func calculateScore(cityScore cityScore: String, usScore: String, reversed: Bool) -> String {
        if let cityScoreAsPercentOfUS = self.cityScoreAsPercentOfUS(cityScore: cityScore, usScore: usScore) {
            return self.scoreName(cityScoreAsPercentOfUS, reversed: reversed)
        } else {
            return "N/A"
        }
    }
    
    
    private func cityScoreAsPercentOfUS(cityScore cityScore: String, usScore: String) -> Double? {
        let cityScoreNoPercent = self.cutPercent(cityScore)
        let usScoreNoPercent = self.cutPercent(usScore)
        
        if let cityScoreAsDouble = Double(cityScoreNoPercent), let usScoreAsDouble = Double(usScoreNoPercent) {
            return cityScoreAsDouble / usScoreAsDouble * 100
        } else {
            return nil
        }
    }
    
    
    private func scoreName(score: Double, reversed: Bool) -> String {
        if !reversed {
            if score > 150 { return Hints.veryHigh}
            else if score > 115 { return Hints.high }
            else if score > 85 { return Hints.average }
            else if score > 65 { return Hints.low }
            else { return Hints.veryLow }
        } else {
            let reversedScore = 1 / score
            return self.scoreName(reversedScore, reversed: false)
        }
    }
    

    private func cutPercent(word: String) -> String {
        if word.characters.last == "%" {
            let truncated = word.substringToIndex(word.endIndex.predecessor())
            return truncated
        } else {
            return word
        }
    }
    

}

