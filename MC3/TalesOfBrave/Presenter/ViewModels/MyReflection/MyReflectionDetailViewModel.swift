//
//  MyReflectionDetailViewModel.swift
//  MC3
//
//  Created by Muhammad Rezky on 28/07/23.
//

import Foundation
import CloudKit

class MyReflectionDetailViewModel: ObservableObject {
    private var storyCloudKitService: StoryCloudKitService = StoryCloudKitService()
    private var ratingCloudKitService: RatingCloudKitService = RatingCloudKitService()
    
    @Published var problem: String = ""
    @Published var story: String = ""
    @Published var reflection: String = ""
    
    func initData(data: HistoryModel) async -> Void {
        problem = data.problem ?? ""
        reflection = data.reflection ?? ""
        
        if(data.story != nil){
            var storyModel: StoryModel?
            do{
                storyModel = try await getStory(story: data.story!)
                if(storyModel != nil){
                    var intro =  storyModel?.introduction.joined(separator: "")
                    var prob =  storyModel?.problem.joined(separator: "")
                    
                    var res =  storyModel?.resolution.joined(separator: "")
                    story = "\(intro). \(problem). \(res)"
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
