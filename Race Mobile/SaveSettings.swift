import UIKit
import Foundation
class SaveSettings{
    var gameSpeed = 3.0
    var carImage = UIImage(named: "car5")
    var barrierImage = UIImage(named: "car5")
    var sound = true
 //   var userPhoto = UIImage(named: "placeholder-man")
    static let shared = SaveSettings()
    init(){}
}
