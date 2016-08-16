//
//  Properties.swift
//  dataPopulation
//
//  Created by Max Tkach on 8/13/16.
//  Copyright © 2016 Anvil. All rights reserved.
//

//import Foundation
//
//
//struct CensusAPIProperties {
//    
//    static let eduTransProperties: [String : [String : String]] = [
//        
//        // TRANSPORATION DATA SETS
//        
//        "B08136": [ // Special Case - average time to be calculated based on other data set value
//            Hints.description: "Travel time to work",
//            Hints.type: Hints.transporation,
//            "001E": "Total travel time to work in minutes"
//        ],
//        
//        "B08301": [
//            Hints.description: "Means of transporation to work",
//            Hints.type: Hints.transporation,
//            "001E": Hints.total,
//            "002E": "Commuting to work by car, truck or van",
//            "003E": "Commuting to work by car, truck or van alone",
//            "010E": "Commuting to work by public transporation",
//            "018E": "Commuting to work by bicycle",
//            "019E": "Walking to work"
//        ],
//        
//        
//        // EDUCATION DATA SET
//        
//        "B15003": [
//            Hints.description: "Educational attainment for population 25 years and over",
//            Hints.type: Hints.education,
//            "001E": Hints.total,
//            "002E": "No schooling completed",
//            "017E": "High school diploma",
//            "018E": "GED or alternative credential",
//            "024E": "Professional school degree",
//            "022E": "Bachelor's degree",
//            "023E": "Master's degree",
//            "025E": "Doctorate degree",
//        ]
//    ]
//    
//    
//    // DEMOGRAPHICS DATA SETS
//    
//    static let demoProperties: [String : [String : String]] = [
//        
//        "B01003": [
//            Hints.description: "Population",
//            Hints.type: Hints.demographics,
//            "001E": "Population"
//        ],
//        
//        "B01002": [
//            Hints.description: "Median age",
//            Hints.type: Hints.demographics,
//            "001E": "Median age",
//            "002E": "Median age - male",
//            "003E": "Median age - female"
//        ],
//        
//        "B25035": [
//            Hints.description: "Median year structure built",
//            Hints.type: Hints.demographics,
//            "001E": "Median year structure built",
//        ],
//        
//        "B01001": [
//            Hints.description: "Population by sex",
//            Hints.type: Hints.demographics,
//            "001E": Hints.total,
//            "002E": "Males",
//            "026E": "Females"
//        ],
//        
//        "B25001": [
//            Hints.description: "Number of houses",
//            Hints.type: Hints.demographics,
//            "001E": "Number of houses",
//        ],
//        
//        "B25003": [
//            Hints.description: "Houses by occupation",
//            Hints.type: Hints.demographics,
//            "001E": Hints.total,
//            "002E": "Owner occupied",
//            "003E": "Renter occupied"
//        ],
//        
//        "B05002": [
//            Hints.description: "Place of birth",
//            Hints.type: Hints.demographics,
//            "001E": Hints.total,
//            "013E": "Foreign born"
//        ],
//        
//        "B03002": [
//            Hints.description: "Diversity",
//            Hints.type: Hints.demographics,
//            "001E": Hints.total,
//            "003E": "White",
//            "004E": "Black or African American",
//            "005E": "American Indian and Alaska Native",
//            "006E": "Asian",
//            "007E": "Pacific islander",
//            "012E": "Hispanic or Latino"
//        ]
//    ]
//    
//    
//    // ECONOMY DATA SETS
//    
//    static let econProperties: [String : [String : String]] = [
//        
//        "B19013": [
//            Hints.description: "Median household income",
//            Hints.type: Hints.economy,
//            "001E": "Median household income"
//        ],
//        
//        "B25077": [
//            Hints.description: "Median house value",
//            Hints.type: Hints.economy,
//            "001E": "Median house value"
//        ],
//        
//        "B25064": [
//            Hints.description: "Median gross rent",
//            Hints.type: Hints.economy,
//            "001E": "Median gross rent"
//        ],
//        
//        "B25071": [
//            Hints.description: "Median gross rent as percentage of household income",
//            Hints.type: Hints.economy,
//            "001E": "Median gross rent as percentage of household income"
//        ],
//        
//        // Have to calculate affordabily index based on above data, special case
//        
//        "B23025": [
//            Hints.description: "Employment",
//            Hints.type: Hints.economy,
//            "001E": Hints.total,
//            "005E": "Unemployed"
//        ],
//        
//        "B17001": [
//            Hints.description: "Poverty",
//            Hints.type: Hints.economy,
//            "001E": Hints.total,
//            "002E": "Below poverty level"
//        ],
//        
//        "C24050": [
//            Hints.description: "Industry by occupation",
//            Hints.type: Hints.economy,
//            "001E": Hints.total,
//            "002E": "Agriculture, forestry, fishing and hunting, and mining",
//            "003E": "Construction",
//            "004E": "Manufacturing",
//            "005E": "Wholesale trade",
//            "006E": "Retail trade",
//            "007E": "Transportation and warehousing, and utilities",
//            "008E": "Information",
//            "009E": "Finance and insurance, and real estate and rental and leasing",
//            "010E": "Professional, scientific, and management, and administrative and waste management services",
//            "011E": "Educational services, and health care and social assistance",
//            "012E": "Arts, entertainment, and recreation, and accommodation and food services",
//            "014E": "Public administration"
//        ]
//    ]
//    
//    static let propertyTypesDictionary: [String : [String : [String : String]]] = [
//        Hints.economy : econProperties,
//        Hints.demographics : demoProperties,
//        Hints.eduAndTrans : eduTransProperties
//    ]
//    
//    private init() {}
//    
//}
//
