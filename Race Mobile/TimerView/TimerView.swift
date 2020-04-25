
import UIKit

class TimerView: UIView {
    
    class func instanceFromNib() -> TimerView{
        return UINib (nibName: "TimerView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TimerView
    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
}
