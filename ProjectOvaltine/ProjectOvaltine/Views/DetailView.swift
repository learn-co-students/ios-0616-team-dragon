//
//  DetailView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class DetailView: UIView {
    var topicLabel: UILabel! = UILabel()
    var scoreLabel: UILabel! = UILabel()
    var descriptionLabel: UILabel = UILabel()
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
    }
}
