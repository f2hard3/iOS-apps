//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12,]
    
    var secondsPassed: Int = 0
    
    var timer: Timer = Timer()
    var player: AVAudioPlayer!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        let totalTime = eggTimes[hardness]!

        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("\(self.secondsPassed) seconds.")
            self.secondsPassed += 1
            self.progressBar.progress = Float(self.secondsPassed) / Float(totalTime)
            
            if self.secondsPassed == totalTime {
                timer.invalidate()
                self.titleLabel.text = "Done!"
                self.playAlarm()
            }
        }
    }
    
    func playAlarm() {
        player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")!))
        player.play()
    }
    
    
    
}
 
