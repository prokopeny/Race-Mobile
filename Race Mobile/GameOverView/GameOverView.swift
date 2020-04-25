
import UIKit
protocol GameOverViewDelegate: AnyObject{
    func restartGame()
    func exitGame()
}
class GameOverView: UIView {
    
    class func instanceFromNib() -> GameOverView{
        return UINib (nibName: "GameOverView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! GameOverView
    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    weak var delegate: GameOverViewDelegate?
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
        boomSound.stop(SoundName: "ButtonSound2")
        boomSound.play(SoundName: "ButtonSound2", numberOfLoops: 0)
        self.removeFromSuperview()
        delegate?.exitGame()
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
        boomSound.stop(SoundName: "ButtonSound2")
        boomSound.play(SoundName: "ButtonSound2", numberOfLoops: 0)
        delegate?.restartGame()
        self.removeFromSuperview()
    }
}
