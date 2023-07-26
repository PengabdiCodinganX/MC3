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
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    let storyDetail = StoryDetail(introduction: $0["introduction"] as! String, problem: $0["problem"] as! String, resolution: $0["resolution"] as! String)
                    return StoryModel(id: $0.recordID, keywords: $0["keywords"] as! [String], story: storyDetail, rating: $0["storyRating"] as! Int64)
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
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    let storyDetail = StoryDetail(introduction: $0["introduction"] as! String, problem: $0["problem"] as! String, resolution: $0["resolution"] as! String)
                    return StoryModel(id: $0.recordID, keywords: $0["keywords"] as! [String], story: storyDetail, rating: $0["storyRating"] as! Int64)
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
        let predicate = NSPredicate(format: "id == %@", id)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query, resultsLimit: 1)
            print("[StoryCloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap {
                    let storyDetail = StoryDetail(introduction: $0["introduction"] as! String, problem: $0["problem"] as! String, resolution: $0["resolution"] as! String)
                    return StoryModel(id: $0.recordID, keywords: $0["keywords"] as! [String], story: storyDetail, rating: $0["storyRating"] as! Int64)
                }
            
            guard let story = data.first else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Story not found"])
            }
            
            return .success(story)
        } catch {
            return .failure(error)
        }
    }
    
    func saveStory(story: StoryModel) async throws -> StoryModel {
        let record = CKRecord(recordType: recordType.rawValue)
        record["keywords"] = story.keywords
        record["introduction"] = story.story.introduction
        record["problem"] = story.story.problem
        record["resolution"] = story.story.resolution
        record["storyRating"] = story.rating
        
            let result = try await cloudKitManager.saveData(record: record)
            let storyDetail = StoryDetail(introduction: story.story.introduction, problem: story.story.problem , resolution: story.story.resolution )
            return StoryModel(id: result.recordID, keywords: story.keywords, story: storyDetail, rating: story.rating)
    }
    
    func updateStory(story: StoryModel) async -> Result<StoryModel, Error> {
        do {
            guard let recordID = story.id else {
                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Story not found"]))
            }
            
            let record = try await cloudKitManager.fetchData(recordID: recordID)
            record["keywords"] = story.keywords
            record["introduction"] = story.story.introduction
            record["problem"] = story.story.problem
            record["resolution"] = story.story.resolution
            record["storyRating"] = story.rating
            
            let result = try await cloudKitManager.saveData(record: record)
            
            let storyDetail = StoryDetail(introduction: story.story.introduction, problem: story.story.problem, resolution: story.story.resolution )
            return .success(
                StoryModel(id: result.recordID, keywords: story.keywords, story: storyDetail, rating: story.rating)
            )
        } catch {
            return .failure(error)
        }
    }
}

