
import UIKit
protocol  SaveRecordViewDelegate: AnyObject{
    func saveGame(name: String?)
    func dontSaveGame()
}
class SaveRecordView: UIView {
    
    class func instanceFromNib() -> SaveRecordView {
        return UINib (nibName: "SaveRecordView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SaveRecordView
    }
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    weak var delegate: SaveRecordViewDelegate?
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        boomSound.stop(SoundName: "ButtonSound2")
        boomSound.play(SoundName: "ButtonSound2", numberOfLoops: 0)
        delegate?.dontSaveGame()
        self.removeFromSuperview()
    }
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        boomSound.stop(SoundName: "ButtonSound2")
        boomSound.play(SoundName: "ButtonSound2", numberOfLoops: 0)
        delegate?.saveGame(name: nameTextField.text)
        self.removeFromSuperview()
    }
    
}

extension SaveRecordView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
    }
}
