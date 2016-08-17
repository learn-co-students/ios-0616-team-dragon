import UIKit
import SnapKit
import GaugeView

class ResultView: UIView {
    
    let store = DataStore.sharedInstance
    private var graphView: GaugeView!
    var scoreLabel: UILabel! = UILabel()
    var locationNameLabel: UILabel! = UILabel()
    var resultDescriptionTextView: UITextView = UITextView()
    let height: CGFloat = UIScreen.mainScreen().bounds.height / 2
    let width: CGFloat = UIScreen.mainScreen().bounds.width
    var graphPercentage: Float = 0
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        super.init(coder: coder)
        self.frame = CGRectMake(0, 0, width, height)
        self.backgroundColor = UIColor.whiteColor()
        self.createGraph()
        self.createLabels()
        self.setupView()
    }
    
    convenience init?(score: String, percentage: Float) {
        self.init(coder: NSCoder.empty())
        self.scoreLabel.text = score
        self.graphPercentage = percentage
    }
    
    func createGraph() {
        self.graphView = GaugeView(frame: CGRect(x:0, y:0, width: 100, height: 100))
        self.graphView.percentage = self.graphPercentage
        self.graphView.thickness = 9
        self.graphView.labelFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        self.graphView.labelColor = UIColor.blueColor()
        self.graphView.gaugeBackgroundColor = UIColor.lightGrayColor()
        self.addSubview(graphView)
    }
    
    func createLabels() {
        self.locationNameLabel.frame = CGRect(x:-10, y: 0, width: 150, height: 40)
        self.locationNameLabel.textColor = UIColor.blackColor()
        self.locationNameLabel.textAlignment = NSTextAlignment.Left
        self.locationNameLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:20)
        self.locationNameLabel.text = "New York County"
        
        self.scoreLabel.frame = CGRect(x:180, y:170, width: 150, height: 40)
        self.scoreLabel.textColor = UIColor.blackColor()
        self.scoreLabel.textAlignment = NSTextAlignment.Left
        self.scoreLabel.font = UIFont(name:"AppleSDGothicNeo-Regular", size:40)
        self.scoreLabel.text = "90"
        
        
        self.resultDescriptionTextView.frame = CGRect(x:10, y:245, width:395, height:90)
        self.resultDescriptionTextView.backgroundColor = UIColor.clearColor()
        self.resultDescriptionTextView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        self.resultDescriptionTextView.font = UIFont(name:"AppleSDGothicNeo-Light", size:16)
        self.addSubview(self.scoreLabel)
        self.addSubview(self.locationNameLabel)
        self.addSubview(self.resultDescriptionTextView)
    }
    
    
    func setupView() {
        self.graphView.snp_makeConstraints { (make) -> Void in
            //make.size.equalTo(1
            make.top.equalTo(self).offset(20)
            make.center.equalTo(self)
            make.size.equalTo(110)
        }
        self.locationNameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(95)
            make.left.equalTo(self).offset(130)
            
        }
        
        //        self.resultDescriptionTextView.snp_makeConstraints { (make) -> Void in
        //            make.top.equalTo(self).offset(40)
        //        }
    }
    
}