//
//  ResultCell.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    var locationNameLabel: UILabel! = UILabel()
    var resultGraph: UIImageView! = UIImageView()
    var locationScoreLabel: UILabel! = UILabel()
    var resultCatagoryLabel: UILabel! = UILabel()
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.locationNameLabel.text = "Test"
        self.resultGraph = UIImageView()
        self.locationScoreLabel.text = "Score"
        self.resultCatagoryLabel.text = "Category"
        
        contentView.addSubview(self.locationNameLabel)
        contentView.addSubview(self.resultGraph)
        contentView.addSubview(self.locationScoreLabel)
        contentView.addSubview(self.resultCatagoryLabel)
        contentView.addSubview(createScoreLabel())
    }
    
    func createScoreLabel() -> UILabel {
        self.locationScoreLabel.frame = CGRectMake(50, 50, 200, 30)
        self.locationScoreLabel.backgroundColor = UIColor.brownColor()
        self.locationScoreLabel.textColor = UIColor.whiteColor()
        self.locationScoreLabel.textAlignment = NSTextAlignment.Left
        self.locationScoreLabel.text = "My First Label"
        return self.locationScoreLabel
    }

//    static let reuseIdentifier: String = "resultCell"
//    
//    var resultGraph:UIImageView! = UIImageView()
//    var locationNameLabel:UILabel! = UILabel()
//    var locationScoreLabel:UILabel! = UILabel()
//    var resultCatagoryLabel:UILabel! = UILabel()
    
    
//    init(style: UITableViewCellStyle, reuseIdentifier: String) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        self.resultGraph.layer.cornerRadius = self.resultGraph.frame.size.width / 2
//        self.resultGraph.clipsToBounds = true
//    }
    
//    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
//        var cell :dynamicCell = tableView.dequeueReusableCellWithIdentifier("cell") as dynamicCell
//    }
//    
//    var resultParameter: String?
//    var view: UIView = UIView()
//    var parameterLabel = UILabel()
//    
//    func createScoreLabel() {
//        self.parameterLabel.frame = CGRectMake(50, 50, 200, 30)
//        self.parameterLabel.backgroundColor = UIColor.brownColor()
//        self.parameterLabel.textColor = UIColor.whiteColor()
//        self.parameterLabel.textAlignment = NSTextAlignment.Left
//        self.parameterLabel.text = "My First Label"
//        self.view.addSubview(self.parameterLabel)
//    }
//    
//    var result: ResultModel! {
//        didSet {
//            self.parameterLabel.text = result.dataParameter
//        }
//    }
    
    
    
    
    
    
    
    
//    var myLabel1: UILabel!
//    var myLabel2: UILabel!
//    var myLabel3: UILabel!
//    var myButton1 : UIButton!
//    //var myButton2 : UIButton!
//    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:)")
//    }
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        myLabel1 = UILabel()
//        myLabel1.frame = CGRectMake(50, 16, 150, 30)
//        myLabel1.textColor = UIColor.blackColor()
//        contentView.addSubview(myLabel1)
//        
//        myLabel2 = UILabel()
//        myLabel2.frame = CGRectMake(20, 16, 30, 30)
//        myLabel2.textColor = UIColor.blackColor()
//        contentView.addSubview(myLabel2)
//        
//        myLabel3 = UILabel()
//        myLabel3.frame = CGRectMake(333, 16, 150, 30)
//        myLabel3.textColor = UIColor.blackColor()
//        contentView.addSubview(myLabel3)
//        //        myLabel3.backgroundColor = UIColor.cyanColor()
//        //        contentView.layer.zPosition = 3
//        
//        myButton1 = UIButton()
//        myButton1.frame = CGRectMake(10, 16, 30, 30)
//        myButton1.setImage(UIImage(named: "green-square.png"), forState: UIControlState.Normal)
//        contentView.addSubview(myButton1)
//        contentView.sendSubviewToBack(myButton1)
//        
//        //        myButton2 = UIButton()
//        //        myButton2.frame = CGRectMake(375, 16, 30, 30)
//        //        myButton2.setImage(UIImage(named: "blue-round-9.png"), forState: UIControlState.Normal)
//        //        contentView.addSubview(myButton2)
//    }

}