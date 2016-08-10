//
//  ResultModel.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
struct ResultModel {
<<<<<<< HEAD
    let subScores: [ScoreModel] = []
    let resultScore: ScoreModel
    let resultLocationName: String
    let dataParameter: String = ""
//    let countyLogo: UIImage!
    
=======
    var subScores: [ScoreModel] = []
    var dataPoints: [String] = []
    let resultScore: ScoreModel
    let resultLocationName: String
    let dataParameter: String
    let countyLogo: UIImage?
>>>>>>> new_chris_branch
    init(score:ScoreModel) {
        self.resultScore = score
        self.resultLocationName = score.scoreName
        self.countyLogo = UIImage()
        self.dataParameter = ""
    }
}
