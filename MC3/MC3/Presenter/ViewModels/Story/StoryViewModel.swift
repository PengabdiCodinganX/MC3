//
//  AuthViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation
import CoreData
import NaturalLanguage

@MainActor
class StoryViewModel: ObservableObject {
    @Published var audioManager: AudioManager = AudioManager()
    
    func playAudio(track: String) {
        audioManager.startPlayer(track: track)
    }
    
    func stopAudio() {
        audioManager.stop()
    }
    
    func setVolume(_ volume: Float) {
        audioManager.setVolume(volume)
    }
    
    func getStageScenes(story: StoryModel) -> [StageScene] {
        return [
            StageScene(name: "a-scene-1", text: story.introduction, soundList: story.introductionSound),
            StageScene(name: "a-scene-2", textColor: .white, text: story.problem, soundList: story.problemSound),
            StageScene(name: "a-scene-3", text: story.resolution, soundList: story.resolutionSound)
        ]
    }
}
