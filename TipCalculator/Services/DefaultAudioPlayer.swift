//
//  DefaultAudioPlayer.swift
//  TipCalculator
//
//  Created by waheedCodes on 08/02/2023.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player = AVAudioPlayer()
    
    // MARK: - Required Method
    
    func playSound() {
        let path = Bundle.main.path(forResource: "Click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}
