
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var grassImageView: UIImageView!
    @IBOutlet weak var asphaltImageView: UIImageView!
    @IBOutlet weak var ghostView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var informationView: UIView!
    
    let explosion = UIImageView()
    let randomCar = UIImageView()
    let car = UIImageView()
    let gameOverView = GameOverView.instanceFromNib()
    let saveRecordView = SaveRecordView.instanceFromNib()
    let newLevelView = NewLevelView.instanceFromNib()
    
    var rightLocation: CGFloat = 0
    var leftLocation: CGFloat = 0
    var updateTimer = Timer()
    var roadTimer = Timer()
    var countdownTimer = Timer()
    var blinkLabelTimer = Timer()
    var lives = 3
    var playing = false
    var gameSpeed = setting.speed
    var level = 1
    var score = 0
    var userName = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        playing = true
        go()
        createCar()
        update()
        createTimerView()
        self.view.isUserInteractionEnabled = false
        definesPresentationContext = true
        
    }
    
    func go (){
        roadTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (_) in
            self.createStripe()
            self.createLeftTrees()
            self.createRightTrees()
        })
    }
    
    func createStripe(){
        let stripeView = UIView()
        let y: CGFloat = -300
        stripeView.frame = CGRect(x: 200, y: y, width: 5, height: 50)
        stripeView.center.x = asphaltImageView.frame.size.width / 2
        stripeView.backgroundColor = .white
        asphaltImageView.addSubview(stripeView)
        UIView.animate(withDuration: gameSpeed, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            stripeView.frame.origin.y = self.view.frame.maxY
        }) { (true) in
            stripeView.removeFromSuperview()
        }
    }
    
    func createLeftTrees() {
        let lefttrees = UIImageView()
        lefttrees.image = UIImage(named: "tree1")
        let y: CGFloat = -150
        lefttrees.frame = CGRect(x: 0, y: y, width: 70, height: 70)
        lefttrees.center.x = asphaltImageView.frame.minX / 2
        grassImageView.addSubview(lefttrees)
        UIView.animate(withDuration: gameSpeed, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            lefttrees.frame.origin.y = self.view.frame.maxY
        }) { (true) in
            lefttrees.removeFromSuperview()
        }
    }
    
    func createRightTrees() {
        let righttrees = UIImageView()
        righttrees.image = UIImage(named: "tree2")
        let x: CGFloat = view.frame.maxX - 65
        let y: CGFloat = -150
        righttrees.frame = CGRect(x: x, y: y, width: 70, height: 70)
        righttrees.center.x = (asphaltImageView.frame.maxX + view.frame.maxX) / 2
        grassImageView.addSubview(righttrees)
        UIView.animate(withDuration: gameSpeed, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            righttrees.frame.origin.y = self.view.frame.maxY
        }) { (true) in
            righttrees.removeFromSuperview()
        }
    }
    
    func createCar() {
        let yPosition = view.frame.maxY - asphaltImageView.frame.size.width / 1.5
        let xPosition = view.center.x
        let width = asphaltImageView.frame.size.width / 4.5
        let height = asphaltImageView.frame.size.width / 2.25
        rightLocation = view.frame.size.width / 2 + asphaltImageView.frame.size.width / 4
        car.image = carArray[setting.carPosition]
        car.contentMode = .scaleAspectFit
        car.frame = CGRect(x: xPosition, y: yPosition, width: width , height: height )
        car.center.x = rightLocation
        view.addSubview(car)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(sender:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(sender:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func createRandomCar() {
        if playing  {
            let height = asphaltImageView.frame.size.width / 2.25
            let width = asphaltImageView.frame.size.width / 4.5
            let leftLocation = view.frame.size.width / 2 - asphaltImageView.frame.size.width / 4
            let rightLocation = view.frame.size.width / 2 + asphaltImageView.frame.size.width / 4
            let arrayX = [leftLocation, rightLocation]
            let yPosition: CGFloat = -height
            let xPosition = ghostView.center.x
            
            randomCar.image = barrierArray[setting.barrierPosition]
            randomCar.contentMode = .scaleAspectFit
            randomCar.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
            randomCar.center.x = arrayX[Int.random(in: 0..<2)]
            ghostView.addSubview(randomCar)
            
            UIView.animate(withDuration: gameSpeed, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.randomCar.frame.origin.y = self.view.frame.maxY
            }) { (true) in
                if self.playing{
                    self.score += 1
                    self.scoreLabel.text = "Score: \(self.score)"
                    if self.score % 10 == 0{
                        self.newLevelView.frame.size.width = self.view.frame.maxX
                        self.newLevelView.frame.size.height = 50
                        self.newLevelView.frame.origin.x = -self.view.frame.maxX
                        self.newLevelView.frame.origin.y = self.informationView.frame.maxY
                        
                        self.view.addSubview(self.newLevelView)
                        UIView.animate(withDuration: 5, delay: 0, options: .curveLinear, animations: {
                            self.newLevelView.frame.origin.x = self.view.frame.maxX
                            self.blinkLabelTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (_) in
                                if self.newLevelView.newLevelLabel.textColor == .red{
                                    self.newLevelView.newLevelLabel.textColor = .clear
                                } else{
                                    self.newLevelView.newLevelLabel.textColor = .red
                                }
                            }
                        }) { (true) in
                            self.newLevelView.removeFromSuperview()
                            self.blinkLabelTimer.invalidate()
                        }
                        
                        self.level += 1
                        self.levelLabel.text = "Level: \(self.level)"
                        self.gameSpeed -= 0.25
                    }
                }
                self.randomCar.removeFromSuperview()
                self.createRandomCar()
            }
        }
    }
    
    func update(){
        
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
            
            if self.randomCar.layer.presentation()?.frame.intersects(self.car.layer.presentation()!.frame) ?? false {
                if self.lives != 1 {
                    self.reduceLife()
                    self.randomCar.removeFromSuperview()
                } else {
                    self.heartImageView.image = UIImage(named: "brokenHeart")
                    self.endGame()
                }
            }
            
            if self.car.frame.minX < self.asphaltImageView.frame.minX  {
                if self.lives != 1 {
                    self.car.removeFromSuperview()
                    self.reduceLife()
                    self.createCar()
                    self.car.center.x = self.rightLocation - self.asphaltImageView.frame.size.width / 2
                } else {
                    self.heartImageView.image = UIImage(named: "brokenHeart")
                    self.endGame()
                } }
            else if self.car.frame.maxX > self.asphaltImageView.frame.maxX{
                if self.lives != 1 {
                    self.car.removeFromSuperview()
                    self.reduceLife()
                    self.car.center.x = self.rightLocation
                    self.createCar()
                } else {
                    self.heartImageView.image = UIImage(named: "brokenHeart")
                    
                    self.endGame()
                }
            }
        })
    }
    
    func reduceLife() {
        self.lives -= 1
        self.heartLabel.text = "\(self.lives)"
        self.createExplosion()
    }
    
    func endGame(){
        randomCar.layer.removeAllAnimations()
        roadTimer.invalidate()
        updateTimer.invalidate()
        playing = false
        self.createExplosion()
        randomCar.removeFromSuperview()
        car.removeFromSuperview()
        let when = DispatchTime.now() + 0.7
        DispatchQueue.main.asyncAfter(deadline: when) {
            gameOverSound.play(SoundName: "GameOver", numberOfLoops: 0)
            self.createSaveRecordAlert()
        }
    }
    
    func createExplosion() {
        boomSound.stop(SoundName: "Boom")
        boomSound.play(SoundName: "Boom", numberOfLoops: 0)
        explosion.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        explosion.center = car.center
        explosion.image = UIImage(named: "boom")
        view.addSubview(explosion)
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.explosion.frame.size.width += 50
            self.explosion.frame.size.height += 50
        }) { (true) in
            self.explosion.removeFromSuperview()
        }
    }
    
    func createJump() {
        self.updateTimer.invalidate()
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.car.transform = CGAffineTransform(scaleX:  1.4, y: 1.4)

        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.car.transform = CGAffineTransform(scaleX:  1, y:  1)

            }) { (true) in
                self.view.isUserInteractionEnabled = true
                self.update()
            }}
    }
    
    func createGameOverAlert(){
        gameOverView.frame = self.view.frame
        gameOverView.center.x = view.center.x
        gameOverView.center.y = view.center.y
        gameOverView.delegate = self
        gameOverView.mainView.roundCorners()
        gameOverView.noButton.roundCorners()
        gameOverView.yesButton.roundCorners()
        gameOverView.mainView.dropShadow(color: .black, shadowOpacity: 10, shadowRadius: 10)
        view.addSubview(gameOverView)
    }
    
    func createSaveRecordAlert() {
        saveRecordView.frame = self.view.frame
        saveRecordView.center.x = view.center.x
        saveRecordView.center.y = view.center.y
        saveRecordView.delegate = self
        saveRecordView.nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter Name", attributes:  [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        saveRecordView.nameTextField.layer.borderWidth = 1
        saveRecordView.nameTextField.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        saveRecordView.nameTextField.roundCorners()
        saveRecordView.mainView.roundCorners()
        saveRecordView.cancelButton.roundCorners()
        saveRecordView.okButton.roundCorners()
        saveRecordView.mainView.dropShadow(color: .black, shadowOpacity: 10, shadowRadius: 10)
        view.addSubview(saveRecordView)
    }
    
    func defaultSettings(){
        self.score = 0
        self.lives = 3
        self.gameSpeed = setting.speed
        self.heartImageView.image = UIImage(named: "heart")
        self.heartLabel.text = "\(self.lives)"
    }
    
    func createTimerView() {
        let timerView = TimerView.instanceFromNib()
        view.isUserInteractionEnabled = false
        timerView.frame = CGRect(x: 0, y: 0, width: view.frame.maxX , height: view.frame.maxY )
        timerView.mainView.roundCorners()
        timerView.mainView.dropShadow(color: .black, shadowOpacity: 5, shadowRadius: 10)
        timerView.center.x = view.center.x
        timerView.center.y = view.center.y
        view.addSubview(timerView)
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            
            if timerView.timerLabel.tag != 1{
                timerView.timerLabel.tag -= 1
                timerView.timerLabel.text = "\(timerView.timerLabel.tag)"
            } else {
                timerView.removeFromSuperview()
                self.countdownTimer.invalidate()
                self.createRandomCar()
                self.view.isUserInteractionEnabled = true
            }
        })
        
    }
    
    @IBAction func leftSwipe ( sender: UISwipeGestureRecognizer){
        UIView.animate(withDuration: 0.3) {
            self.car.frame.origin.x -= self.asphaltImageView.frame.size.width / 2
        }
    }
    
    @IBAction func rightSwipe ( sender: UISwipeGestureRecognizer){
        UIView.animate(withDuration: 0.3) {
            self.car.frame.origin.x += self.asphaltImageView.frame.size.width / 2
        }
    }
    
    @IBAction func tap (sender: UITapGestureRecognizer){
        createJump()
    }
}

extension ViewController: GameOverViewDelegate, SaveRecordViewDelegate{
    
    func saveGame(name: String?) {
        RecordsManager.shared.addItem(name: name ?? "No Name", count: self.score, UIImage: setting.imageData)
        self.defaultSettings()
        self.createGameOverAlert()
    }
    
    func dontSaveGame() {
        self.defaultSettings()
        self.createGameOverAlert()
    }
    
    func restartGame() {
        self.playing = true
        self.createCar()
        self.go()
        self.update()
        self.createTimerView()
    }
    
    func exitGame() {
        self.navigationController?.popViewController(animated: true)
    }
}
