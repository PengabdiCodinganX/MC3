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
                    return StoryModel(problemCategory: $0["category"] as! String, story: storyDetail)
                }
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getAllStoryByCategory(categories: [CategoryModel]) async -> Result<[StoryModel], Error> {
        let references = categories.map { CKRecord.Reference(recordID: $0.id, action: .none) }
        let predicates = references.map { NSPredicate(format: "categories CONTAINS %@", $0) }
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        let query = CKQuery(recordType: recordType.rawValue, predicate: compoundPredicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query)
            print("[StoryCloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    let storyDetail = StoryDetail(introduction: $0["introduction"] as! String, problem: $0["problem"] as! String, resolution: $0["resolution"] as! String)
                    return StoryModel(problemCategory: $0["category"] as! String, story: storyDetail)
                }
            
            return .success(data)
        } catch {
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
                .compactMap{
                    let storyDetail = StoryDetail(introduction: $0["introduction"] as! String, problem: $0["problem"] as! String, resolution: $0["resolution"] as! String)
                    return StoryModel(problemCategory: $0["category"] as! String, story: storyDetail)
                }
            
            guard let story = data.first else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sound not found"])
            }
            
            return .success(story)
        } catch {
            return .failure(error)
        }
    }
    
    func saveStory(story: StoryModel) async -> Result<StoryModel, Error> {
        let record = CKRecord(recordType: recordType.rawValue)
        record["category"] = story.problemCategory
        record["introduction"] = story.story.introduction
        record["problem"] = story.story.problem
        record["resolution"] = story.story.resolution
        
        do {
            let result = try await cloudKitManager.saveData(record: record)
            
            let storyDetail = StoryDetail(introduction: story.story.introduction, problem: story.story.problem , resolution: story.story.resolution )
            return .success(
                StoryModel(id: result.recordID, problemCategory: story.problemCategory, story: storyDetail)
            )
        } catch {
            return .failure(error)
        }
    }
}

