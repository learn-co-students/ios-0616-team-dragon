//
//  AppControllerDataProvider.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AppControllerDataProvider: NSObject, UITableViewDataSource {
    private let cellIdentifer = "resultCell"
    func registerCellsForTableView(tableView: UITableView) {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifer, forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select:\(indexPath.row)")
    }
}
