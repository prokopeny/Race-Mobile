
import Foundation
import  AVFoundation
struct SoundManager {
    var audioPlayer = AVAudioPlayer()
    
    mutating func playerForFile(fileName: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
    }
    
    mutating func play(SoundName: String, numberOfLoops: Int) {
        if setting.sound == true{
            audioPlayer.volume = 1
            playerForFile(fileName: SoundName)
            audioPlayer.numberOfLoops = numberOfLoops
            audioPlayer.play()
        } else{
            audioPlayer.volume = 0
        }
    }
    
    mutating func stop(SoundName: String){
        playerForFile(fileName: SoundName)
        audioPlayer.stop()
    }
    
    mutating func pause(SoundName: String)  {
        playerForFile(fileName: SoundName)
        audioPlayer.pause()
    }
    
}
