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
    private var elevenLabsService: ElevenLabsAPIService?
    
    @Published var story: StoryModel?
    @Published var audioPlayer: AVAudioPlayer?
    
    init() { Task {
        elevenLabsService = try await ElevenLabsAPIService()
    } }
    
}
