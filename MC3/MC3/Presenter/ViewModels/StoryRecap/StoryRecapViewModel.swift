//
//  StoryRecapViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation

@MainActor
class StoryRecapViewModel: ObservableObject{
    private var audioManager: AudioManager = AudioManager()
    private var ratingCloudKitService: RatingCloudKitService = RatingCloudKitService()
    
    func playAudio(sound: Data) {
        audioManager.startPlayer(data: sound)
    }
    
    func saveRating(rate: Int) async throws {
        let rating = RatingModel(rating: Int64(rate))
        let result = await ratingCloudKitService.saveRating(rating: rating)
        
        switch result {
        case .success(_): break
            // TODO
        case .failure(_): break
            // TODO
        }
    }
}
