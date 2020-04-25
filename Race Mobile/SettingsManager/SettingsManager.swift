
import Foundation
import  UIKit
class SettingsManager {
    
    var sound = true
    var speed = 3.0
    var carPosition = 0
    var barrierPosition = 0
    var speedPosition = 0
    var imageData = userPhoto!.jpegData(compressionQuality: 0.1)
    
    func saveData(){
        UserDefaults.standard.set(sound, forKey: "sound")
        UserDefaults.standard.set(speed, forKey: "gameSpeed")
        UserDefaults.standard.set(carPosition, forKey: "carPosition")
        UserDefaults.standard.set(barrierPosition, forKey: "barrierPosition")
        UserDefaults.standard.set(speedPosition, forKey: "speedPosition")
        UserDefaults.standard.set(imageData, forKey: "imageData")
        UserDefaults.standard.synchronize()
    }
    
    func loadData(){
        if let loadSound = UserDefaults.standard.value(forKey: "sound") as? Bool {
            sound = loadSound
        }
        if let loadGameSpeed = UserDefaults.standard.value(forKey: "gameSpeed") as? Double {
            speed = loadGameSpeed
        }
        if let loadCarPosition = UserDefaults.standard.value(forKey: "carPosition") as? Int {
            carPosition = loadCarPosition
        }
        if let loadBarrierPosition = UserDefaults.standard.value(forKey: "barrierPosition") as? Int {
            barrierPosition = loadBarrierPosition
        }
        if let loadSpeedPosition = UserDefaults.standard.value(forKey: "speedPosition") as? Int {
            speedPosition = loadSpeedPosition
        }
        if let loadImageData = UserDefaults.standard.value(forKey: "imageData") as? Data {
            imageData = loadImageData
        }
    }
    
}
