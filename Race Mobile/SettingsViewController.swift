import UIKit

class SettingsViewController: UIViewController {
        
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var barrierImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var blur: UIVisualEffectView!
    
    let imagePicker = UIImagePickerController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        saveButton.roundCorners()
        soundButton.roundCorners()
        saveButton.dropShadow(color: .black, shadowOpacity: 10, shadowRadius: 10)
        carImageView.image = carArray[setting.carPosition]
        barrierImageView.image = barrierArray[setting.barrierPosition]
        speedLabel.text = speedArray[setting.speedPosition]
        imagePicker.delegate = self
        userPhotoImageView.image = UIImage(data: setting.imageData!)
        userPhotoImageView.layer.cornerRadius = 20
        let tap = UITapGestureRecognizer(target: self, action: #selector(pick(sender:)))
        tap.numberOfTapsRequired = 1
        self.userPhotoImageView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setting.loadData()
        userPhotoImageView.contentMode = .scaleAspectFill
        if setting.sound == true{
            soundButton.backgroundColor = .systemGreen
        }else{
            soundButton.backgroundColor = .red
        }
    }
    
    func updateSpeed(speedName: String) -> Double {
        
        var correctSpeed: Double
        switch speedName {
        case "easy": correctSpeed = 3.0
        case "medium": correctSpeed = 2.0
        case "hard": correctSpeed = 1.5
        default:
            correctSpeed = 3.0
        }
        return correctSpeed
    }
    
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        if setting.sound == true{
            setting.sound = false
            soundButton.backgroundColor = .red
        }else{
            setting.sound = true
            soundButton.backgroundColor = .systemGreen
        }
    }
    
    @IBAction func goLeftCar(_ sender: UIButton) {
        if setting.carPosition > 0 && setting.carPosition <= carArray.count - 1{
            setting.carPosition -= 1
            carImageView.image = carArray[setting.carPosition]
        }
    }
    
    @IBAction func goRightCar(_ sender: UIButton) {
        if setting.carPosition >= 0 && setting.carPosition < carArray.count - 1{
            setting.carPosition += 1
            carImageView.image = carArray[setting.carPosition]
        }
    }
    
    @IBAction func goLeftBarrier(_ sender: UIButton) {
        if setting.barrierPosition > 0 && setting.barrierPosition <= barrierArray.count - 1{
            setting.barrierPosition -= 1
            barrierImageView.image = barrierArray[setting.barrierPosition]
        }
    }
    
    @IBAction func goRightBarrier(_ sender: UIButton) {
        if setting.barrierPosition >= 0 && setting.barrierPosition < barrierArray.count - 1{
           setting.barrierPosition += 1
            barrierImageView.image = barrierArray[setting.barrierPosition]
        }
    }
    
    @IBAction func speedDecrease(_ sender: UIButton) {
        
        if setting.speedPosition > 0 && setting.speedPosition <= speedArray.count - 1{
            setting.speedPosition -= 1
            speedLabel.text = speedArray[setting.speedPosition]
            setting.speed = updateSpeed(speedName: speedArray[setting.speedPosition])
        }
    }
    
    @IBAction func speedIncrease(_ sender: UIButton) {
        
        if setting.speedPosition >= 0 && setting.speedPosition < speedArray.count - 1{
            setting.speedPosition += 1
            speedLabel.text = speedArray[setting.speedPosition]
            setting.speed = updateSpeed(speedName: speedArray[setting.speedPosition])
        }
    }
    
    @IBAction func pick ( sender: UITapGestureRecognizer){
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        setting.saveData()
        buttonSound.stop(SoundName: "buttonSound")
        buttonSound.play(SoundName: "buttonSound", numberOfLoops: 0)
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            userPhotoImageView.image = pickedImage
            setting.imageData = userPhotoImageView.image!.jpegData(compressionQuality: 0.1)
            userPhotoImageView.contentMode = .scaleAspectFill
            self.dismiss(animated: true, completion: nil)
        }
    }
}
