//
//  ResultTableViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let resultVC = ResultView()
    let resultTableVC = ResultFeedTableView()
    
    override func viewDidLoad() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return nil
//    }

}

//: UIViewController, UITableViewDelegate, UITableViewDataSource,
