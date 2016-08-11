//
//  Navigable.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol Navigable {
    //implemented in extension
}

extension Navigable {
    func setupNavBar() -> UINavigationBar {
        let appController = AppController()
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, appController.view.frame.size.width, 64))
        return navigationBar
    }
}
