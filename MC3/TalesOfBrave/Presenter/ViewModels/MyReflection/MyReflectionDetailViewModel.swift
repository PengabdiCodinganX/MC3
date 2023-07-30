//
//  MyReflectionDetailViewModel.swift
//  MC3
//
//  Created by Muhammad Rezky on 28/07/23.
//

import Foundation
import CloudKit
@MainActor
class MyReflectionDetailViewModel: ObservableObject {
    private var storyCloudKitService: StoryCloudKitService = StoryCloudKitService()
    private var ratingCloudKitService: RatingCloudKitService = RatingCloudKitService()
    
    @Published var problem: String = ""
    @Published var story: String = ""
    @Published var reflection: String = ""
    
    func initData(data: HistoryModel) async -> Void {
        print("[data]", data)
        problem = data.problem ?? ""
        reflection = data.reflection ?? ""
        
        if(data.story != nil){
            var storyModel: StoryModel?
            do{
                storyModel = try await getStory(story: data.story!)
                if(storyModel != nil){
                    let intro =  storyModel?.introduction.joined(separator: "")
                    let prob =  storyModel?.problem.joined(separator: "")
                    
                    let res =  storyModel?.resolution.joined(separator: "")
                    story = "\(intro.unsafelyUnwrapped). \(prob.unsafelyUnwrapped). \(res.unsafelyUnwrapped)"
                }
            }
            catch{
                print(error)
            }
        }
    }
    
    
    func getStory(story: CKRecord.Reference) async throws -> StoryModel? {
        let storyRecordID = story.recordID
        let result = await storyCloudKitService.getStory(id: storyRecordID)
        
        switch result {
        case .success(let success):
            print("[getStory][success]", success)
            return success
        case .failure(let failure):
            print("kfqwnflqwkndqw", failure)
            return nil
        }
    }
    
    func getRating(rating: CKRecord.Reference) async throws -> RatingModel? {
        let ratingRecordID = rating.recordID
        let result = await ratingCloudKitService.getRating(id: ratingRecordID)
        
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            print("kfqwnflqwkndqw", failure)
            return nil
        }
    }
}
