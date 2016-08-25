//
//  NavBar.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/16/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class NavBar {
    let width: CGFloat = UIScreen.mainScreen().bounds.width
    
    func setup() -> UINavigationBar {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width:self.width, height: 40))
        
        navBar.layer.zPosition = 3
        navBar.barTintColor = UIColor(red:0.36, green:0.49, blue:0.55, alpha:1.0)
        navBar.titleTextAttributes = [ NSFontAttributeName:HelveticaLight().getFont(20), //UIFont(name:"Helvetica-Light", size: 20)!,
            
            NSForegroundColorAttributeName: UIColor.blackColor()]
        navBar.layer.borderColor = UIColor.blackColor().CGColor
        
        return navBar
    }
}
