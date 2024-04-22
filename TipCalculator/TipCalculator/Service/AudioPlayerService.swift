//
//  AudioPlayerService.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/16.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        var url: URL
        if #available(iOS 16.0, *) {
            url = URL(filePath: path)
        } else {
            url = URL(fileURLWithPath: path)
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
