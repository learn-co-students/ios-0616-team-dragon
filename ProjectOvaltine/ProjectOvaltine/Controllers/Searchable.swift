//
//  Searchable.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
protocol Searchable: UISearchBarDelegate {
    //implemented in extension
}

extension Searchable {
    func setupSearch() -> (UISearchBar, NSLayoutConstraint) {
        let appController: AppController! = AppController()
        let searchController = UISearchBar().dynamicType.init()
        var topConstraint = NSLayoutConstraint()
       // searchController.placeholder = "Enter Location"
        searchController.frame = CGRect(x: 0, y: 0, width: appController.view.frame.size.width, height: 66)
        topConstraint = NSLayoutConstraint(item: searchController, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: appController.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        searchController.delegate = self
        return(searchController, topConstraint)
    }
//        appController.addSubview(searchController)
//        appController.addConstraint(topConstraint)
}