import UIKit
import SnapKit
import GaugeView

class ResultView: UIView {
    
    let store = DataStore.sharedInstance
    var comparrisonData: ScoreModel?
    
    let states = [State]()
    
    var heightLayoutConstraint = NSLayoutConstraint()
    var bottomLayoutConstraint = NSLayoutConstraint()
    
    var containerView = UIView()
    var containerLayoutConstraint = NSLayoutConstraint()
    
    
    var scoreLabel: UILabel! = UILabel()
    var locationNameLabel: UILabel! = UILabel()
    var countyNameLabel: UILabel! = UILabel()
    var communityRatingLabel: UILabel! = UILabel()
    //var resultDescriptionTextView: UITextView = UITextView()
    let height: CGFloat = UIScreen.mainScreen().bounds.height / 2.3
    let width: CGFloat = UIScreen.mainScreen().bounds.width
    var graphPercentage: Float = 90
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.comparrisonData = self.store.comparisonData
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.frame = CGRectMake(0, 0, width, height)
        self.backgroundColor = UIColor.whiteColor()
   //     self.createGraph()
        self.createLabels()
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.setupView()
    }
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
        self.frame = CGRectMake(0, 0, width, height)
        self.backgroundColor = UIColor.whiteColor()
   //     self.createGraph()
        self.createLabels()
        self.setupView()
    }
    
    //    func scrollViewDidScroll(scrollView: UIScrollView) {
    //        self.containerLayoutConstraint.constant = scrollView.contentInset.top;
    //        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
    //        self.containerView.clipsToBounds = offsetY <= 0
    //        self.bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
    //        self.heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    //    }
    
    convenience init?(score: String, percentage: Float) {
        self.init(coder: NSCoder.empty())
        self.scoreLabel.text = score
        self.graphPercentage = percentage
        self.setupView()
    }
    
    
    func setupConstraints() {
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.backgroundColor = UIColor.grayColor()
        self.addSubview(self.containerView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["containerView" : self.containerView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[containerView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["containerView" : self.containerView]))
        self.containerLayoutConstraint = NSLayoutConstraint(item: self.containerView,
                                                            attribute: .Height,
                                                            relatedBy: .Equal,
                                                            toItem: self,
                                                            attribute: .Height,
                                                            multiplier: 1.0, constant: 0.0)
        self.addConstraint(self.containerLayoutConstraint)
        let newView: UIView = UIView.init()
        newView.frame = CGRectMake(0, 0, 150, 150)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = UIColor.blueColor()
        newView.clipsToBounds = true
        newView.contentMode = .ScaleAspectFill
        self.containerView.addSubview(newView)
    }
    
    func createLabels() {
        
        var shortenedCity = ""
        
        if let cityName = self.store.cityName {
            shortenedCity = CensusAPIClient().actualName(cityName)}
        
        self.locationNameLabel.textColor = UIColor.blackColor()
        self.locationNameLabel.textAlignment = NSTextAlignment.Center
        self.locationNameLabel.adjustsFontSizeToFitWidth = true
        self.locationNameLabel.font = HelveticaLight().getFont(20)
        self.locationNameLabel.text = shortenedCity
        
       

        
        self.countyNameLabel.textColor = UIColor.blackColor()
        self.countyNameLabel.textAlignment = NSTextAlignment.Center
        self.countyNameLabel.adjustsFontSizeToFitWidth = true
        self.countyNameLabel.font = HelveticaLight().getFont(20)
        self.countyNameLabel.text = self.store.countyName
        
        self.scoreLabel.textColor = UIColor.blackColor()
        self.scoreLabel.textAlignment = NSTextAlignment.Center
        self.scoreLabel.font = HelveticaLight().getFont(20)
        self.scoreLabel.text = self.store.cityScoresByType[Hints.absolute]
        //self.scoreLabel.backgroundColor = UIColor(netHex: 0xA6F6AF)
        if self.scoreLabel.text == "Very Low"{self.scoreLabel.backgroundColor = UIColor.redColor()}
        else if self.scoreLabel.text == "Low"{self.scoreLabel.backgroundColor = UIColor.orangeColor()}
        else if self.scoreLabel.text == "Average"{self.scoreLabel.backgroundColor = UIColor.yellowColor()}
        else{self.scoreLabel.backgroundColor = UIColor(netHex: 0xA6F6AF)}
        self.scoreLabel.layer.masksToBounds = true
        self.scoreLabel.layer.cornerRadius = 50
        
        self.communityRatingLabel.textColor = UIColor.blackColor()
        self.communityRatingLabel.textAlignment = NSTextAlignment.Center
        self.communityRatingLabel.adjustsFontSizeToFitWidth = true
        self.communityRatingLabel.font = HelveticaLight().getFont(20)
        self.communityRatingLabel.text = "Community Rating"
        
        self.addSubview(self.scoreLabel)
        self.addSubview(self.locationNameLabel)
        self.addSubview(self.countyNameLabel)
        self.addSubview(self.communityRatingLabel)
    }
    
    func setupView() {
        self.scoreLabel.snp_makeConstraints { (make) -> Void in
            //make.centerX.equalTo(self)
            make.left.equalTo(30)
            make.centerY.equalTo(self).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        self.locationNameLabel.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(175)
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(66)
            //make.right.equalTo(-5)
        }
        self.countyNameLabel.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(150)
            make.centerY.equalTo(self).offset(33)
            make.centerX.equalTo(self).offset(66)
            //make.right.equalTo(-5)
        }
        self.communityRatingLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.centerY.equalTo(self).offset(90)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
}