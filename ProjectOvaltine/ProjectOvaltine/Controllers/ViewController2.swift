//
//  ViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/4/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import SwiftSpinner


class ViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    private var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = CitySDKAPIClient()
        
        print(api.sendAPIRequest())
        
        self.view.backgroundColor=UIColor.whiteColor()
        
        navBarSearch()

    }
    
//    override func viewDidAppear(animated: Bool) {
//        
//        SwiftSpinner.showWithDuration(1.9, title: "TEAM DRAGON")
//        
//        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
//    }
    
    func searchButtonTapped(){
        
        let detailVC = DetailViewController()
        presentViewController(detailVC, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResultsForSearchController(self.searchController!)
    }
    
    func navBarSearch() {
        
        self.definesPresentationContext = true
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self    // this controller is delegate
        self.searchController!.searchResultsUpdater = self
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.searchBarStyle = .Minimal
        self.tableView.tableHeaderView = self.searchController.searchBar
    }
    
}


