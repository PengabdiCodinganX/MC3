//
//  StoryRecapViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import AVFAudio
import CloudKit

class StoryRecapViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private let appStorageService: AppStorageService = AppStorageService()
    
    private var ratingCloudKitService: RatingCloudKitService = RatingCloudKitService()
    private var historyCloudKitService: HistoryCloudKitService = HistoryCloudKitService()
    private var userCloudKitService: UserCloudKitService = UserCloudKitService()
    
    @Published var audioManager: AudioManager = AudioManager()
    @Published var currentIndex: Int = 0
    @Published var isPlaying: Bool = false
    
    func getStoryData(story: StoryModel) -> [String] {
        let introduction = story.introduction.joined()
        let problem = story.problem.joined()
        let resolution: String = story.resolution.joined()
        
        return [introduction, problem, resolution]
    }
    
    func getStoryAudio(story: StoryModel) -> [Data] {
        let soundDataArrays = [story.introductionSound, story.problemSound, story.resolutionSound]
        
        var storyAudio: [Data] = []
        
        for soundDataArray in soundDataArrays {
            if let sounds = soundDataArray {
                storyAudio.append(contentsOf: sounds)
            } else {
                return []
            }
        }
        
        return storyAudio
    }
    
    func playAudio(sound: Data) {
        audioManager.startPlayer(data: sound)
        audioManager.delegatePlayer(delegate: self)
        isPlaying = true
    }
    
    func saveRating(rate: Int, story: StoryModel) async throws -> RatingModel? {
        let user = try await getUser()
        guard let userRecordID = user?.id else {
            print("user record not found.")
            // handle case when user id is nil
            return nil
        }
        
        let userReference = CKRecord.Reference(recordID: userRecordID, action: .none)
        
        guard let storyRecordID = story.id else {
            // handle case when user id is nil
            return nil
        }
        
        let storyReference = CKRecord.Reference(recordID: storyRecordID, action: .none)
        let rating = RatingModel(rating: Int64(rate), user: userReference, story: storyReference)
        let result = await ratingCloudKitService.saveRating(rating: rating)
        switch result {
        case .success(let success):
            return success
        case .failure(_):
            return nil
        }
    }
    
    func getUser() async throws -> UserModel? {
        let userIdentifier = self.appStorageService.userIdentifier
        print("[PermissionViewModel][getUser][userIdentifier]", userIdentifier)
        
        let result = await self.userCloudKitService.getUser(userIdentifier: userIdentifier)
        switch result {
        case .success(let user):
            return user
        case .failure(let failure):
            print("failure", failure)
            return nil
        }
    }
    
    func updateHistory(history: HistoryModel, rating: RatingModel) async -> HistoryModel? {
        guard let ratingRecordID = rating.id else {
            return nil
        }
        
        let ratingReference = CKRecord.Reference(recordID: ratingRecordID, action: .none)
        var historyUpdate = history
        historyUpdate.rating = ratingReference
        
        let result = await historyCloudKitService.updateHistory(history: historyUpdate)
        
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            print("failure", failure)
            return nil
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Perform any additional checks or actions you want here
        print("[audioPlayerDidFinishPlaying][flag]", flag)
        isPlaying = !flag
    }
}
