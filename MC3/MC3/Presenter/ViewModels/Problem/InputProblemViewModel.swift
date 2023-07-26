//
//  InputProblemView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 25/07/23.
//

import Foundation
import CloudKit
import AVFAudio

@MainActor
class InputProblemViewModel: ObservableObject {
    private var storyCloudKitService: StoryCloudKitService = StoryCloudKitService()
    private var soundCloudKitService: SoundCloudKitService = SoundCloudKitService()
    
    private var elevenLabsService: ElevenLabsAPIService?
    
    @Published var story: StoryModel?
    @Published var audioPlayer: AVAudioPlayer?
    
    init() { Task {
        elevenLabsService = try await ElevenLabsAPIService()
    } }
    
    // this function is not for this view, move it to after breathing
    func getStoryByCategories() async {
        print("[getStoryByCategories]")
        
        let categories = ["exam"]
        
        let result = await storyCloudKitService.getStoryByKeywords(keywords: categories)
        
        switch result {
        case .success(let story):
            print("story", story)
            self.story = story
        case .failure(let failure):
            print("[getStoryByCategories][failure]", failure)
        }
    }
    
    func getSoundByText(text: String) async throws {
        let audio = try await elevenLabsService?.fetchTextToSpeech(text: text)
        let sound = SoundModel(text: text, sound: audio)
        let result = await soundCloudKitService.saveSound(sound: sound)
        
        switch result {
        case .success(let data):
            guard data.sound != nil else {
                return
            }
            
            audioPlayer = try AVAudioPlayer(data: data.sound!)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        case .failure(let failure):
            print("[getSoundByText][failure]", failure)
        }
    }
}
