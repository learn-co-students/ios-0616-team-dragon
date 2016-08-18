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
    
//    func setupConstraints() {
//        self.containerView.translatesAutoresizingMaskIntoConstraints = false
//        self.containerView.backgroundColor = UIColor.grayColor()
//        self.createGraph()
//        self.addSubview(self.containerView)
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : self.containerView]))
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : self.containerView]))
//        self.containerLayoutConstraint = NSLayoutConstraint(item: self.containerView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0.0)
//        self.addConstraint(self.containerLayoutConstraint)
//        let newView: UIView = UIView.init()
//        newView.frame = CGRectMake(0, 0, 150, 150)
//        newView.translatesAutoresizingMaskIntoConstraints = false
//        newView.backgroundColor = UIColor.blueColor()
//        newView.clipsToBounds = true
//        newView.contentMode = .ScaleAspectFill
//        self.createGraph()
//        newView.addSubview(self.graphView)
//        self.containerView.addSubview(newView)
//        
//        //
//        //
//        //        imageView.translatesAutoresizingMaskIntoConstraints = false
//        //        //imageView.backgroundColor = UIColor.whiteColor()
//        //        imageView.clipsToBounds = true
//        //        imageView.contentMode = .ScaleAspectFill
//        //        //imageView.image = UIImage(named: "Apple-Touch-ID-Promo")
//        //        self.containerView.addSubview(imageView)
//        //
//        //
//        self.containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[newView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["newView": newView]))
//        self.bottomLayoutConstraint = NSLayoutConstraint(item: newView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
//        self.containerView.addConstraint(bottomLayoutConstraint)
//        self.heightLayoutConstraint = NSLayoutConstraint(item: newView, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1.0, constant: 0.0)
//        self.containerView.addConstraint(heightLayoutConstraint)
        //self.createGraph()
        
        //        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        //        self.imageView.backgroundColor = UIColor.whiteColor()
        //        self.imageView.clipsToBounds = true
        //        self.imageView.contentMode = .ScaleAspectFill
        //        self.imageView.image = self.drawImage(frame, scale:(UIScreen.mainScreen().scale))
        //        self.imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 60))
        // self.imageView.
        //        self.containerView.addSubview(self.imageView)
        
        
        //        self.containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : self.imageView]))
        //       self.bottomLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self.containerView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        //        self.containerView.addConstraint(self.bottomLayoutConstraint)
        //        self.heightLayoutConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Height, relatedBy: .Equal, toItem: self.containerView, attribute: .Height, multiplier: 1.0, constant: 0.0)
        //self.containerView.addConstraint(self.heightLayoutConstraint)
        //        imageView.snp_makeConstraints { (make) -> Void in
        //            make.size.equalTo(50)
        //        }
//    }
    
    
    // func drawImage(frame: CGRect, scale: CGFloat) -> UIImage {
    //     let image = YODonutChartImage()
    //    image.donutWidth = 16.0
    //    image.labelText = "LABEL"
    //   image.labelColor = UIColor.whiteColor()
    //     image.values = [10.0, 20.0, 70.0]
    //     image.colors = (0..<3).map { _ in randomColor() }
    //
    //     let drawnImage = image.drawImage(frame, scale: scale)
    //returnImage.size.heigh
    //let returnImage = self.resizeImage(drawnImage, newWidth: 20)
    
    //  return drawnImage
    //}
    
    
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
    
    //private func randomColor() -> UIColor {
    //    let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
    //    let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
    //    let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
    //   return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    //}
}
//    let store = DataStore.sharedInstance
//
//    var heightLayoutConstraint = NSLayoutConstraint()
//    var bottomLayoutConstraint = NSLayoutConstraint()
//
//    var containerView = UIView()
//    var containerLayoutConstraint = NSLayoutConstraint()
//
//    var scoreLabel: UILabel! = UILabel()
//    var locationNameLabel: UILabel! = UILabel()
//    var resultDescriptionTextView: UITextView = UITextView()
//    let height: CGFloat = UIScreen.mainScreen().bounds.height / 2
//    let width: CGFloat = UIScreen.mainScreen().bounds.width
//
//    override init(frame:CGRect) {
//        super.init(frame: frame)
//        self.containerView.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    required init?(coder: NSCoder = NSCoder.empty()) {
//        super.init(coder: coder)
//        self.frame = CGRectMake(0, 0, width, height)
//        self.backgroundColor = UIColor.whiteColor()
//        //self.createGraph()
//        self.createLabels()
//        self.setupView()
//    }
//
//    convenience init?(score: String) {
//        self.init(coder: NSCoder.empty())
//        self.scoreLabel.text = score
////        self.graphPercentage = percentage
//    }
//
////    func createGraph() {
////        self.graphView = GaugeView(frame: CGRect(x:120, y:130, width: 100, height: 100))
////        self.graphView.percentage = self.graphPercentage
////        self.graphView.thickness = 9
////        self.graphView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
////        self.graphView.labelColor = UIColor.blueColor()
////        self.graphView.gaugeBackgroundColor = UIColor.lightGrayColor()
////        self.addSubview(graphView)
////    }
//
//    func createLabels() {
//        self.locationNameLabel.frame = CGRect(x:110, y: 90, width: 150, height: 40)
//        self.locationNameLabel.textColor = UIColor.blackColor()
//        self.locationNameLabel.textAlignment = NSTextAlignment.Left
//        self.locationNameLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
//        self.locationNameLabel.text = "New York County"
//
//        self.scoreLabel.frame = CGRect(x:148, y:164, width: 150, height: 40)
//        self.scoreLabel.textColor = UIColor.blackColor()
//        self.scoreLabel.textAlignment = NSTextAlignment.Left
//        self.scoreLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:40)
//        self.scoreLabel.text = "90"
//
//
//        self.resultDescriptionTextView.frame = CGRect(x:10, y:245, width:300, height:90)
//        self.resultDescriptionTextView.backgroundColor = UIColor.clearColor()
//        self.resultDescriptionTextView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
//        self.resultDescriptionTextView.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
//        self.addSubview(self.scoreLabel)
//        self.addSubview(self.locationNameLabel)
//        self.addSubview(self.resultDescriptionTextView)
//    }
//
//
//    func setupView() {
//        //        self.graphView.snp_makeConstraints { (make) -> Void in
//        //            //make.size.equalTo(1
//        //            make.top.equalTo(self).offset(20)
//        //            make.center.equalTo(self)
//        //            make.size.equalTo(110)
//        //        }
//        //        self.locationNameLabel.snp_makeConstraints { (make) -> Void in
//        //            make.top.equalTo(self).offset(95)
//        //            make.left.equalTo(self).offset(130)
//        //
//        //        }
//
//        //        self.resultDescriptionTextView.snp_makeConstraints { (make) -> Void in
//        //            make.top.equalTo(self).offset(40)
//        //        }
//    }
//
//
//}
//
//    var scoreLabel: UILabel! = UILabel()
//    var locationNameLabel: UILabel! = UILabel()
//    var resultDescriptionTextView: UITextView = UITextView()
//
//    var heightLayoutConstraint = NSLayoutConstraint()
//    var bottomLayoutConstraint = NSLayoutConstraint()
//
//    var containerView = UIView()
//    var containerLayoutConstraint =  NSLayoutConstraint()
//    let image = YODonutChartImage()
//    let imageView: UIImageView = UIImageView.init()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = UIColor.whiteColor()
//        //imageView.image = self.drawImage(frame, scale:UIScreen.mainScreen().scale)
//
//
//        self.createLabels()
//        self.createConstraints()
//        imageView.image = self.drawImage(frame, scale:UIScreen.mainScreen().scale)
//    }
//
//    func createConstraints(){
//        self.containerView.translatesAutoresizingMaskIntoConstraints = false
//        self.containerView.backgroundColor = UIColor.redColor()
//        self.addSubview(containerView)
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView]))
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView]))
//
//        self.containerLayoutConstraint = NSLayoutConstraint(item: self.containerView, attribute: .Height, relatedBy: .Equal, toItem: self,  attribute: .Height, multiplier: 1.0, constant: 0.0)
//        self.addConstraint(containerLayoutConstraint)
//
//
//        //        let newView: UIView = UIView.init()
//        //        newView.frame = CGRectMake(0, 0, 150, 150)
//        //        newView.translatesAutoresizingMaskIntoConstraints = false
//        //        newView.backgroundColor = UIColor.blueColor()
//        //        newView.clipsToBounds = true
//        //        newView.contentMode = .ScaleAspectFill
//        //        self.containerView.addSubview(newView)
//
//
//
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        //imageView.backgroundColor = UIColor.whiteColor()
//        imageView.clipsToBounds = true
//        imageView.contentMode = .ScaleAspectFill
//        //imageView.image = UIImage(named: "Apple-Touch-ID-Promo")
//        self.containerView.addSubview(imageView)
//
//
//        self.containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": imageView]))
//        self.bottomLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
//        self.containerView.addConstraint(bottomLayoutConstraint)
//        self.heightLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1.0, constant: 0.0)
//        self.containerView.addConstraint(heightLayoutConstraint)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//      self.containerLayoutConstraint.constant = scrollView.contentInset.top
//       let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
//        self.containerView.clipsToBounds = offsetY <= 0
//     self.bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
//        self.heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
//
//
//    }
//
//
//    func createLabels() {
//        self.locationNameLabel.frame = CGRect(x:110, y: 90, width: 150, height: 40)
//        self.locationNameLabel.textColor = UIColor.blackColor()
//        self.locationNameLabel.textAlignment = NSTextAlignment.Left
//        self.locationNameLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
//        self.locationNameLabel.text = "New York County"
//
//        self.scoreLabel.frame = CGRect(x:148, y:164, width: 150, height: 40)
//        self.scoreLabel.textColor = UIColor.blackColor()
//        self.scoreLabel.textAlignment = NSTextAlignment.Left
//        self.scoreLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:40)
//        self.scoreLabel.text = "90"
//
//
//        self.resultDescriptionTextView.frame = CGRect(x:10, y:245, width:300, height:90)
//        self.resultDescriptionTextView.backgroundColor = UIColor.clearColor()
//        self.resultDescriptionTextView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
//        self.resultDescriptionTextView.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
//        self.addSubview(self.scoreLabel)
//        self.addSubview(self.locationNameLabel)
//        self.addSubview(self.resultDescriptionTextView)
//    }
//
//    func drawImage(frame: CGRect, scale: CGFloat) -> UIImage {
//        let image = YODonutChartImage()
//        image.donutWidth = 16.0
//        image.labelText = "LABEL"
//        image.labelColor = UIColor.whiteColor()
//        image.values = [10.0, 20.0, 70.0]
//        image.colors = (0..<3).map { _ in randomColor() }
//        return image.drawImage(frame, scale: scale)
//    }
//
//    private func randomColor() -> UIColor {
//        let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
//        let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
//        let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
//        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//


























