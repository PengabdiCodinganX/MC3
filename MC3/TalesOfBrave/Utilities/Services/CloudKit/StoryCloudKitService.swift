//
//  StoryCloudKitService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 25/07/23.
//

import Foundation
import Foundation
import CloudKit

class StoryCloudKitService {
    private let cloudKitManager: CloudKitManager = CloudKitManager()
    private  let recordType: RecordType = .story
    
    func getAllStory() async -> Result<[StoryModel], Error> {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query)
            print("[StoryCloudKitService][getAllStory][result]", result)
            
            let data = result.matchResults.compactMap { _, result in try? result.get() }.compactMap {
                StoryModel(id: $0.recordID, keywords: $0["keywords"] as! [String], introduction: $0["introduction"] as! [String], problem: $0["problem"] as! [String], resolution: $0["resolution"] as! [String], introductionSound: $0["introductionSound"] as? [Data], problemSound: $0["problemSound"] as? [Data], resolutionSound: $0["resolutionSound"] as? [Data])
            }
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getStoryByKeywords(keywords: [String]) async -> Result<StoryModel, Error> {
        do {
            print("[getStoryByCategory][keywords]", keywords)
            
            // Create predicates for each reference
            let predicate = NSPredicate(format: "ANY %K IN %@", "keywords", keywords)
            
            let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
            
            let result = try await cloudKitManager.fetchData(query: query)
            print("[StoryCloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults.compactMap { _, result in try? result.get() }.compactMap {
                StoryModel(id: $0.recordID, keywords: $0["keywords"] as! [String], introduction: $0["introduction"] as! [String], problem: $0["problem"] as! [String], resolution: $0["resolution"] as! [String], introductionSound: $0["introductionSound"] as? [Data], problemSound: $0["problemSound"] as? [Data], resolutionSound: $0["resolutionSound"] as? [Data])
            }
                .sorted { $0.rating > $1.rating } // Descending by rating
            
            guard let story = data.first else {
                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Story not found"]))
            }
            
            return .success(story)
        } catch {
            print("[getStoryByCategory][error]", error)
            return .failure(error)
        }
    }
    
    func getStory(id: CKRecord.ID) async -> Result<StoryModel, Error> {
        do {
            let data = try await cloudKitManager.fetchData(recordID: id)
            
            return .success(
                StoryModel(id: data.recordID, keywords: data["keywords"] as! [String], introduction: data["introduction"] as! [String], problem: data["problem"] as! [String], resolution: data["resolution"] as! [String], introductionSound: data["introductionSound"] as? [Data], problemSound: data["problemSound"] as? [Data], resolutionSound: (data["resolutionSound"] as? [Data]))
            )
        } catch {
            return .failure(error)
        }
    }
    
    func saveStory(story: StoryModel) async throws -> StoryModel {
        let record = CKRecord(recordType: recordType.rawValue)
        record["keywords"] = story.keywords
        record["storyRating"] = story.rating
        record["introduction"] = story.introduction
        record["problem"] = story.problem
        record["resolution"] = story.resolution
        record["introductionSound"] = story.introductionSound
        record["problemSound"] = story.problemSound
        record["resolutionSound"] = story.resolutionSound

        
        let result = try await cloudKitManager.saveData(record: record)
        
        return StoryModel(
            id: result.recordID,
            keywords: story.keywords,
            rating: story.rating,
            introduction: story.introduction,
            problem: story.problem,
            resolution: story.resolution,
            introductionSound: story.introductionSound,
            problemSound: story.problemSound,
            resolutionSound: story.resolutionSound
        )
    }
    
    func updateStory(story: StoryModel) async -> Result<StoryModel, Error> {
        do {
            guard let recordID = story.id else {
                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Story not found"]))
            }
            
            let record = try await cloudKitManager.fetchData(recordID: recordID)
            record["keywords"] = story.keywords
            record["storyRating"] = story.rating
            record["introduction"] = story.introduction
            record["problem"] = story.problem
            record["resolution"] = story.resolution
            record["introductionSound"] = story.introductionSound
            record["problemSound"] = story.problemSound
            record["resolutionSound"] = story.resolutionSound
            
            let result = try await cloudKitManager.saveData(record: record)
            return .success(
                StoryModel(
                    id: result.recordID,
                    keywords: story.keywords,
                    rating: story.rating,
                    introduction: story.introduction,
                    problem: story.problem,
                    resolution: story.resolution,
                    introductionSound: story.introductionSound,
                    problemSound: story.problemSound,
                    resolutionSound: story.resolutionSound
                )
            )
        } catch {
            return .failure(error)
        }
    }
}

