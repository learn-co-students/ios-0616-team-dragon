//
//  TestView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/18/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import YOChartImageKit
import SnapKit
import GaugeView

class TestView: UIView {
    
    
    var heightLayoutConstraint = NSLayoutConstraint()
    var bottomLayoutConstraint = NSLayoutConstraint()
    
    private var graphView: GaugeView!
    
    var containerView = UIView()
    var containerLayoutConstraint = NSLayoutConstraint()
    
    let imageView: UIImageView = UIImageView.init(frame: CGRectMake(0, 0, 10, 150))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        // The container view is needed to extend the visible area for the image view
        // to include that below the navigation bar. If this container view isn't present
        // the image view would be clipped at the navigation bar's bottom and the parallax
        // effect would not work correctly
        
        self.setupConstraints()
        //
        //        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        //        self.containerView.backgroundColor = UIColor.redColor()
        //        self.addSubview(self.containerView)
        //        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : self.containerView]))
        //        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : self.containerView]))
        //        self.containerLayoutConstraint = NSLayoutConstraint(item: self.containerView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0.0)
        //        self.addConstraint(self.containerLayoutConstraint)
        //
        //
        //        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        //        self.imageView.backgroundColor = UIColor.whiteColor()
        //        self.imageView.clipsToBounds = true
        //        self.imageView.contentMode = .ScaleAspectFill
        //        self.imageView.image = UIImage(named: "Apple-Touch-ID-Promo")
        //        self.containerView.addSubview(self.imageView)
        //        self.containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : self.imageView]))
        //        self.bottomLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self.containerView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        //        self.containerView.addConstraint(self.bottomLayoutConstraint)
        //        self.heightLayoutConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Height, relatedBy: .Equal, toItem: self.containerView, attribute: .Height, multiplier: 1.0, constant: 0.0)
        //        self.containerView.addConstraint(self.heightLayoutConstraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.containerLayoutConstraint.constant = scrollView.contentInset.top;
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
        self.containerView.clipsToBounds = offsetY <= 0
        self.bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        self.heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    
    func setupConstraints() {
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.backgroundColor = UIColor.grayColor()
        self.createGraph()
        self.addSubview(self.containerView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : self.containerView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : self.containerView]))
        self.containerLayoutConstraint = NSLayoutConstraint(item: self.containerView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0.0)
        self.addConstraint(self.containerLayoutConstraint)
        let newView: UIView = UIView.init()
        newView.frame = CGRectMake(0, 0, 150, 150)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = UIColor.blueColor()
        newView.clipsToBounds = true
        newView.contentMode = .ScaleAspectFill
        self.createGraph()
        newView.addSubview(self.graphView)
        self.containerView.addSubview(newView)
    }
    
    func createGraph() {
        self.graphView = GaugeView(frame: CGRect(x:0, y:100, width: 300, height: 200))
        self.graphView.percentage = 90
        self.graphView.thickness = 9
        self.graphView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        self.graphView.labelColor = UIColor.blueColor()
        self.graphView.gaugeBackgroundColor = UIColor.lightGrayColor()
        self.containerView.addSubview(self.graphView)
    }
    
    
    //    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
    //
    //        //let scale = newWidth / image.size.width
    //
    //        let newHeight = image.size.height / 2
    //        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
    //        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //
    //        return newImage
    //    }
    
}






















