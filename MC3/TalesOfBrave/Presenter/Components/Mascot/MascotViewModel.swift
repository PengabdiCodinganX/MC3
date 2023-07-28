//
//  MascotViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import AVFAudio

class MascotViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var audioManager: AudioManager = AudioManager()
    @Published var isPlaying: Bool = false
    
    func playAudio(track: String) {
        audioManager.startPlayer(track: track)
        audioManager.delegatePlayer(delegate: self)
        isPlaying = true
    }
    
    func stopAudio() {
        audioManager.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Perform any additional checks or actions you want here
        print("[audioPlayerDidFinishPlaying][flag]", flag)
        isPlaying = !flag
    }
}
