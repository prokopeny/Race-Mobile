import UIKit

class NewLevelView: UIView {
    
    class func instanceFromNib() -> NewLevelView{
        return UINib (nibName: "NewLevelView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! NewLevelView
    }
    
    @IBOutlet weak var newLevelLabel: UILabel!

}
