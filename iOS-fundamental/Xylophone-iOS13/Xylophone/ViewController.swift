import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    @IBAction func keyPressed(_ sender: UIButton) {
        playSound(soundName: sender.currentTitle!)
        dimButton(button: sender)
        
    }
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        do {
            player = try AVAudioPlayer.init(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func dimButton(button: UIButton) {
        button.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            button.alpha = 1
        }
    }
}

