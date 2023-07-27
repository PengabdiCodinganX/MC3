//
//  RatingCloudKitService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import CloudKit

class RatingCloudKitService {
    private let cloudKitManager: CloudKitManager = CloudKitManager()
    private  let recordType: RecordType = .rating
    
    func getAllRatingByStory(story: CKRecord.Reference) async -> Result<[RatingModel], Error> {
        let predicate = NSPredicate(format: "story == %@", story)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query)
            print("[RatingCloudKitService][getAllRatingByStory][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    RatingModel(id: $0.recordID, rating: $0["rating"])
                }
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getRating(id: CKRecord.ID) async -> Result<RatingModel, Error> {
        do {
            let data = try await cloudKitManager.fetchData(recordID: id)
            print("[CloudKitService][fetchApiKeyData][data]", data)
            
            return .success(RatingModel(id: data.recordID, rating: data["rating"]))
        } catch {
            return .failure(error)
        }
    }
    
    func saveRating(rating: RatingModel) async -> Result<RatingModel, Error> {
        let record = CKRecord(recordType: recordType.rawValue)
        record["rating"] = rating.rating
        
        do {
            let result = try await cloudKitManager.saveData(record: record)
            
            return .success(
                RatingModel(id: result.recordID, rating: rating.rating)
            )
        } catch {
            return .failure(error)
        }
    }
}
