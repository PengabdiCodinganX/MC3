//
//  MeditationViewModel.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import Foundation

class MeditationViewModel: ObservableObject{
    var meditation: MusicModel = MusicModel(musicType: .meditation)
    @Published var audioManager: AudioManager = AudioManager()
    
    @Published private var breathText: String = "Breathe in..."
    @Published private var value: Double = 0.0
    @Published private var isEditing: Bool = false
    @Published private var isFinished: Bool = false
    
    
    
    func playMusic(){
        audioManager.startPlayer(track: meditation.track)
    }
    
}
