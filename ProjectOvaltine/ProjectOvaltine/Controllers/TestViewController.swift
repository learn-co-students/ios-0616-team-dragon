//
//  TestViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/18/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TestViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let transportNavBar = NavBar().setup()
        self.view.addSubview(transportNavBar)
        
        self.tableView.tableHeaderView = TestView.init(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 335));
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! TestView
        headerView.scrollViewDidScroll(scrollView)
    }
}