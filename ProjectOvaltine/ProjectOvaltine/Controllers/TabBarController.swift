//
//  TabBarController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
class TabBarController: UITabBarController, UITabBarControllerDelegate, Navigable {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.view.addSubview(self.setupNavBar())
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = DetailViewController()
        let tabTwo = ResultViewController()
        let tabThree = EconomicDetailViewController()
        let tabFour = EducationDetailViewController()
        
        tabOne.tabBarItem.title = "Details"
        tabOne.tabBarItem.image = UIImage(named: "heart")
        tabTwo.tabBarItem.title = "Results"
        tabTwo.tabBarItem.image = UIImage(named: "star")
        tabThree.tabBarItem.title = "Economics"
        tabFour.tabBarItem.title = "Education"
        
        let controllers = [tabOne, tabTwo, tabThree, tabFour]
        self.viewControllers = controllers
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }
    
    //let iconOne = UITabBarItem(title: "Title", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
    //item1.tabBarItem = icon1
}