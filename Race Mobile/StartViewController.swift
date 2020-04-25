
import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.roundCorners()
        startButton.dropShadow(color: .black, shadowOpacity: 10, shadowRadius: 10)
        recordsButton.roundCorners()
        recordsButton.dropShadow(color: .black, shadowOpacity: 10, shadowRadius: 10)
        settingsButton.roundCorners()
        settingsButton.dropShadow(color: .black, shadowOpacity: 10, shadowRadius: 10)
        self.navigationController?.navigationBar.isHidden = true     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gameOverSound.stop(SoundName: "GameOver")
        mainSound.play(SoundName: "MainSound", numberOfLoops: 10)
    }
    
    @IBAction func recordsButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController else {
            return
        }
        mainSound.stop(SoundName: "MainSound")
        buttonSound.play(SoundName: "buttonSound", numberOfLoops: 0)        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        mainSound.stop(SoundName: "MainSound")
        buttonSound.play(SoundName: "buttonSound", numberOfLoops: 0)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            return
        }
        mainSound.stop(SoundName: "MainSound")
        buttonSound.play(SoundName: "buttonSound", numberOfLoops: 0)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
