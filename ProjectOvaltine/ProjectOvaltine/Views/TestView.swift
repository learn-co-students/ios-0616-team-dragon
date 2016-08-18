//
//  TestView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/18/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TestView: UIView {
    var heightLayoutConstraint = NSLayoutConstraint()
    var bottomLayoutConstraint = NSLayoutConstraint()
    
    var containerView = UIView()
    var containerLayoutConstraint =  NSLayoutConstraint()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.backgroundColor = UIColor.redColor()
        self.addSubview(containerView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView]))

        self.containerLayoutConstraint = NSLayoutConstraint(item: self.containerView, attribute: .Height, relatedBy: .Equal, toItem: self,  attribute: .Height, multiplier: 1.0, constant: 0.0)
        self.addConstraint(containerLayoutConstraint)
        
        
        let newView: UIView = UIView.init()
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = UIColor.blueColor()
        newView.clipsToBounds = true
        newView.contentMode = .ScaleAspectFill
        self.containerView.addSubview(newView)
        self.containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H: [newView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["newView": newView]))
        self.bottomLayoutConstraint = NSLayoutConstraint(item: newView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.containerView.addConstraint(bottomLayoutConstraint)
        self.heightLayoutConstraint = NSLayoutConstraint(item: newView, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1.0, constant: 0.0)
        self.containerView.addConstraint(heightLayoutConstraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}







































