//
//  AudioManager.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import Foundation
import AVKit

class AudioManager: ObservableObject{
    @Published var player: AVAudioPlayer?
    @Published private(set) var isPlaying: Bool = false {
        didSet{
            print("isPlaying", isPlaying)
        }
    }
    
    func startPlayer(track: String, isPreview: Bool = false){
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else{
            print("Resource not found: \(track)")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            
            if isPreview{
                player?.prepareToPlay()
            }else{
                player?.play()
                isPlaying = true
            }
        } catch  {
            print("Fail to initialize player", error)
        }
    }
    
    func playPause(){
        guard let player = player else{
            print("Instance of audio player not found")
            return
        }
        
        if player.isPlaying{
            player.pause()
            isPlaying = false
        }else{
            player.play()
            isPlaying = true
        }
    }
    
    func stop(){
        guard let player = player else{
            print("Instance of audio player not found")
            return
        }
        
        if player.isPlaying{
            player.stop()
            player.currentTime = 0
            isPlaying = false
        }
    }
}
