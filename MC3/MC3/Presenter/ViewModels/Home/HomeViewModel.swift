//
//  HomeViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import Foundation
import SwiftUI
import AVFAudio

@MainActor
class HomeViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    private let soundCoreDataService: SoundCoreDataService = SoundCoreDataService()
    
    @Published var dailyMotivation: String = ""
    
    @Published var soundList: [SoundModel] = []
    
    init() {
        self.getAllSound()
    }
    
    func getDailyMotivation() {
        //  TODO
    }
    
    func saveSound(text: String) async throws {
        let data = try await ElevenLabsAPIService().fetchTextToSpeech(text: text, voiceId: "21m00Tcm4TlvDq8ikWAM")
        
        let sound = SoundModel(
            id: UUID(),
            sound: data
        )
        
        let result = soundCoreDataService.saveSound(sound: sound)
        
        switch result {
        case .success(let success):
            print("success", success)
            break
        case .failure(let failure):
            print("failure", failure)
            break
        }
        
        self.getAllSound()
    }
    
    func getAllSound() {
        let result = soundCoreDataService.getAllSounds()
        
        switch result {
        case .success(let soundList):
            withAnimation {
                self.soundList = soundList
            }
        case .failure(let failure):
            print("[getAllSound][failure]", failure)
            break
        }
    }
}
