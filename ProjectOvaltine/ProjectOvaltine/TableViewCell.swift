//
//  TableViewCell.swift
//  ProjectOvaltine
//
//  Created by John Hussain on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ComparisonCell: UITableViewCell {
    
    var originLabel: UILabel!
    var comparisonLabel: UILabel!
    var originButton: UIButton!
    var comparisonButton: UIButton!
    var scoreLabel: UILabel!
    
    var myLabel1: UILabel!
    var myLabel2: UILabel!
    var myLabel3: UILabel!
    var myButton1 : UIButton!
    var myButton2 : UIButton!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.originLabel = UILabel()
        self.comparisonLabel = UILabel()
        self.scoreLabel = UILabel()
        self.originLabel.textColor = UIColor.blackColor()
        self.comparisonLabel.textColor = UIColor.blackColor()
        self.scoreLabel.textColor = UIColor.blackColor()
        self.contentView.addSubview(self.originLabel)
        self.contentView.addSubview(self.comparisonLabel)
        self.contentView.addSubview(self.scoreLabel)
        self.originButton = UIButton()
        self.comparisonButton = UIButton()
        self.contentView.addSubview(self.originButton)
        self.contentView.addSubview(self.comparisonButton)
        

    }
}





//
//        self.myLabel1 = UILabel()
//        self.myLabel1.textColor = UIColor.blackColor()
//        self.contentView.addSubview(myLabel1)
//        self.myLabel1.font = UIFont(name:"Helvetica-Light", size:16)
//        //myLabel1.font = UIFont.systemFontOfSize(13.9)
//        self.myLabel1.textColor = UIColor(netHex:0x000000)
//        self.myLabel1.textAlignment = NSTextAlignment.Center
//        self.myLabel1.snp_makeConstraints { (make) -> Void in
//            make.center.equalTo(myLabel1)
//            make.center.equalTo(contentView)//.offset(CGPointMake(0, -3))
//            make.width.equalTo(333)
//            make.height.equalTo(30)
//        }
//
//        self.myLabel2 = UILabel()
//        self.myLabel2.frame = CGRectMake(16, 16, 30, 30)
//        self.myLabel2.font = UIFont.boldSystemFontOfSize(16.0)
//        self.myLabel2.textColor = UIColor.blackColor()
//        self.contentView.addSubview(myLabel2)
//        self.myLabel2.textAlignment = NSTextAlignment.Center
//        self.myLabel2.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(contentView).offset(15)
//            make.top.equalTo(contentView).offset(16)
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//        }
//
//        self.myLabel3 = UILabel()
//        self.myLabel3.frame = CGRectMake(333, 16, 150, 30)
//        self.myLabel3.textColor = UIColor.blackColor()
//        self.contentView.addSubview(myLabel3)
//        //        myLabel3.backgroundColor = UIColor.cyanColor()
//        //        contentView.layer.zPosition = 3
//
//
//        self.myButton1 = UIButton()
//        self.myButton1.setImage(UIImage(named: "ratingTarget.png"), forState: UIControlState.Normal)
//        self.contentView.addSubview(myButton1)
//        self.contentView.sendSubviewToBack(myButton1)
//        self.myButton1.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(contentView).offset(55)
//            make.top.equalTo(contentView).offset(16)
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//        }
//
//        self.myButton2 = UIButton()
//        self.myButton2.setImage(UIImage(named: "ratingTarget.png"), forState: UIControlState.Normal)
//        self.contentView.addSubview(myButton2)
//        self.myButton2.snp_makeConstraints { (make) -> Void in
//            make.right.equalTo(contentView).offset(-55)
//            make.top.equalTo(contentView).offset(16)
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//        }