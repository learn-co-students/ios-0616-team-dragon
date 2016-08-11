//
//  ResultTableViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MapKit
import SwiftSpinner

class ResultViewController: UIViewController {
    //let resultView =
    override func loadView() {
        super.loadView()
        self.view = ResultView()!.view
        //self.view.addSubview(ResultView()!)
    //self.view.addSubview(self.resultView!)
        
//        self.view.addSubview(resultTableView)
//        self.resultTableView.dataSource = self
//        self.resultTableView.delegate = self

        //self.resultTableView.dataSource = dataProvider

        //self.dataProvider?.registerCellsForTableView(self.resultTableView)
        //self.resultTableView.registerClass(ResultCell.self, forCellReuseIdentifier: "resultCell")
        
       // self.view.addSubview(self.resultTableView)
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.showWithDuration(1.3, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
    }
    
}

//class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//class ResultViewController: UITableViewController {
//    
//    //var dataProvider: AppControllerDataProvider?
//    
//   let resultView = ResultView()
//   let resultTableView = ResultTableView()
//    
//    override func loadView() {
//        super.loadView()
//        self.view.addSubview(resultTableView)
////        self.resultTableView.dataSource = self
////        self.resultTableView.delegate = self
//        
//        //self.resultTableView.dataSource = dataProvider
//        
//        //self.dataProvider?.registerCellsForTableView(self.resultTableView)
//        self.resultTableView.registerClass(ResultCell.self, forCellReuseIdentifier: "resultCell")
//        self.view.addSubview(self.resultView)
//        self.view.addSubview(self.resultTableView)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let scrollOptionsButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(ResultViewController.showScrollOptions))
//        self.navigationItem.rightBarButtonItem = scrollOptionsButton
//    }
//    
//    func showScrollOptions() {
//        // not implemented yet
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath)
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("did select:\(indexPath.row)")
//    }
//
//}