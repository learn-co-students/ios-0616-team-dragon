//
//  Navigable.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

import UIKit

protocol Navigable {
    //implemented in extension
}

extension Navigable {
    func setupNavBar() -> UINavigationBar {
        let appFonty = AppFont()
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 90))
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:appFonty.appFontName, size:appFonty.appFontSize)!, NSForegroundColorAttributeName: UIColor.blueColor()]
        let navigationItem = UINavigationItem(title: "Project Ovaltine")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: nil)
        navigationItem.leftBarButtonItem = homeItem
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }
}
