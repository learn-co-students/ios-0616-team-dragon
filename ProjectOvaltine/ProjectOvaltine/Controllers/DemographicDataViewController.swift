//
//  DemographicDataViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class DemographicDataViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        navBar()
        detailImage()
    }
    
    func detailImage() {
        //********** creating UIImageView Programmatically******//
        
        let imageView = UIImageView(frame: CGRectMake(0, 20, 425, 690))
        let image = UIImage(named: "detail-info.png")
        imageView.image = image
        //imageView.layer.cornerRadius = imageView.frame.size.width / 4
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func navBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Demographics")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem
        
        navBar.setItems([navItem], animated: false)
        navBar.alpha = 1.0
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navItem.rightBarButtonItem = barButton
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingButtonPushed() {
        //not implemented yet
    }
}
