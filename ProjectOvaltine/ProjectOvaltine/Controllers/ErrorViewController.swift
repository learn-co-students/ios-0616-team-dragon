//
//  ErrorViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/17/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    override func viewDidLoad() {
        self.setErrorView()
    }
    
    func setErrorView() {
        let errorView = ErrorView()
        self.view.addSubview(errorView)
    }
}
