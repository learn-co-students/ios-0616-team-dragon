import UIKit
import SnapKit
import GaugeView

class ResultView: UIView {
    
    let store = DataStore.sharedInstance
    
    private var graphView: GaugeView!
    
    var heightLayoutConstraint = NSLayoutConstraint()
    var bottomLayoutConstraint = NSLayoutConstraint()
    
    var containerView = UIView()
    var containerLayoutConstraint = NSLayoutConstraint()
    
    var scoreLabel: UILabel! = UILabel()
    var locationNameLabel: UILabel! = UILabel()
    var resultDescriptionTextView: UITextView = UITextView()
    let height: CGFloat = UIScreen.mainScreen().bounds.height / 2
    let width: CGFloat = UIScreen.mainScreen().bounds.width
    var graphPercentage: Float = 90
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.frame = CGRectMake(0, 0, width, height)
        self.backgroundColor = UIColor.whiteColor()
        self.createGraph()
        self.createLabels()
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.setupView()
    }
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
        self.frame = CGRectMake(0, 0, width, height)
        self.backgroundColor = UIColor.whiteColor()
        self.createGraph()
        self.createLabels()
        self.setupView()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.containerLayoutConstraint.constant = scrollView.contentInset.top;
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
        self.containerView.clipsToBounds = offsetY <= 0
        self.bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        self.heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    convenience init?(score: String, percentage: Float) {
        self.init(coder: NSCoder.empty())
        self.scoreLabel.text = score
        self.graphPercentage = percentage
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
        self.graphView = GaugeView(frame: CGRect(x:self.width / 2.5, y:130, width: 100, height: 100))
        self.graphView.percentage = self.graphPercentage
        self.graphView.thickness = 9
        self.graphView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        self.graphView.labelColor = self.randomColor()
        self.graphView.gaugeBackgroundColor = self.randomColor()
        self.addSubview(graphView)
    }
    
    func createLabels() {
        self.locationNameLabel.frame = CGRect(x:self.width/3, y: 90, width: 150, height: 40)
        self.locationNameLabel.textColor = UIColor.blackColor()
        self.locationNameLabel.textAlignment = NSTextAlignment.Left
        self.locationNameLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
        self.locationNameLabel.text = "New York County"
        
        self.scoreLabel.frame = CGRect(x:self.width/2.15, y: 165, width: 150, height: 40)
        self.scoreLabel.textColor = UIColor.blackColor()
        self.scoreLabel.textAlignment = NSTextAlignment.Left
        self.scoreLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:40)
        self.scoreLabel.text = "90"
        
        
        self.resultDescriptionTextView.frame = CGRect(x:10, y:275, width:self.width - 20, height:90)
        self.resultDescriptionTextView.backgroundColor = UIColor.clearColor()
        self.resultDescriptionTextView.text = "Lorem Ipsum is simply dummy text of computing/printing and typeset industry."
        self.resultDescriptionTextView.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
        self.addSubview(self.scoreLabel)
        self.addSubview(self.locationNameLabel)
        self.addSubview(self.resultDescriptionTextView)
    }
    
    func setupView() {
    }
    
    private func randomColor() -> UIColor {
        let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
        let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
        let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
       return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
}