//
//  MeditationViewModel.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import Foundation
//import Combine

class BreathingViewModel: ObservableObject{
    @Published var audioManager: AudioManager = AudioManager()
    @Published var value: Double = 0.0
    @Published private var isEditing: Bool = false
    @Published var timer: Timer?
    
    private(set) var breathText: [String] = ["Breathe in...", "Hold...", "Breathe out..."]
    var meditation: MusicModel = MusicModel(musicType: .meditation)
    
    func prepareMusic(){
        audioManager.startPlayer(track: meditation.track, isPreview: true)
        setTimer()
    }
    
    func setTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.changeCurrentTimePlayerReceive()
        })
    }
    
    func startPauseMusic(){
        audioManager.playPause()
        if timer == nil{
            setTimer()
        }
    }
    
    func stopMusic(){
        audioManager.stop()
        guard let timer = timer else { return }
        guard let player = audioManager.player else { return }
        player.currentTime = 0
        timer.invalidate()
        self.timer = nil
    }
    
    func changeCurrentTimeSlider(editing: Bool){
        guard let player = audioManager.player else { return }
        isEditing = editing
        print("isEditing slider", isEditing)
        if !editing{
            player.currentTime = value
        }
    }
    
    func changeCurrentTimePlayerReceive(){
        guard let player = audioManager.player, !isEditing else { return }
        self.value = player.currentTime
        print("Receive value: ", value)
    }
    
    func changeBackOrForward(isBackward: Bool){
        guard let player = audioManager.player else { return }
        if isBackward{
            player.currentTime -= 10
        }else{
            player.currentTime += 10
        }
    }
}
