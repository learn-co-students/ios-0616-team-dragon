//
//  TableViewCell.swift
//  ProjectOvaltine
//
//  Created by John Hussain on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    var myLabel1: UILabel!
    var myLabel2: UILabel!
    var myLabel3: UILabel!
    var myButton1 : UIButton!
    //var myButton2 : UIButton!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        myLabel1 = UILabel()
        myLabel1.frame = CGRectMake(50, 16, 150, 30)
        myLabel1.textColor = UIColor.blackColor()
        contentView.addSubview(myLabel1)
        
        myLabel2 = UILabel()
        myLabel2.frame = CGRectMake(20, 16, 30, 30)
        myLabel2.textColor = UIColor.blackColor()
        contentView.addSubview(myLabel2)
        
        myLabel3 = UILabel()
        myLabel3.frame = CGRectMake(333, 16, 150, 30)
        myLabel3.textColor = UIColor.blackColor()
        contentView.addSubview(myLabel3)
//        myLabel3.backgroundColor = UIColor.cyanColor()
//        contentView.layer.zPosition = 3
        
        myButton1 = UIButton()
        myButton1.frame = CGRectMake(10, 16, 30, 30)
        myButton1.setImage(UIImage(named: "green-square.png"), forState: UIControlState.Normal)
        contentView.addSubview(myButton1)
        contentView.sendSubviewToBack(myButton1)
        
//        myButton2 = UIButton()
//        myButton2.frame = CGRectMake(375, 16, 30, 30)
//        myButton2.setImage(UIImage(named: "blue-round-9.png"), forState: UIControlState.Normal)
//        contentView.addSubview(myButton2)
    }
    
}