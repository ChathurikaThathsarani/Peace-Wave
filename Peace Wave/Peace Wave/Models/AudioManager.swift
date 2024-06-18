//
//  AudioManager.swift
//  Peace Wave
//
//  Created by Chathurika Dombepola on 2024-06-09.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    private var player: AVAudioPlayer?
    
    // Load the audio file
    func loadSound(sound: String) {
        if let url = Bundle.main.url(forResource: sound, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
            } catch {
                print("Error: Couldn't load sound.")
            }
        }
    }
    
    // Play the audio
    func playSound(sound: String) {
        player?.play()
    }
    
    // Pause the audio
    func pauseSound() {
        player?.pause()
    }
    
    // Forward the audio by a specific time interval
    func forward(by seconds: TimeInterval) {
        guard let player = player else { return }
        player.currentTime += seconds
        if player.currentTime > player.duration {
            player.currentTime = player.duration
        }
    }
    
    // Rewind the audio by a specific time interval
    func rewind(by seconds: TimeInterval) {
        guard let player = player else { return }
        player.currentTime -= seconds
        if player.currentTime < 0 {
            player.currentTime = 0
        }
    }
    
    // Seek to a specific time in the audio
    func seek(to time: Double) {
        player?.currentTime = time
    }
    
    // Get the duration of the audio
    func getDuration() -> Double {
        return player?.duration ?? 0
    }
    
    // Get the current playback time
    func getCurrentTime() -> Double {
        return player?.currentTime ?? 0
    }
}
