//
//  StoryCloudKitService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 25/07/23.
//

import Foundation
import CloudKit

class HistoryCloudKitService {
    private let cloudKitManager: CloudKitManager = CloudKitManager()
    private  let recordType: RecordType = .history
    
    func getAllHistoryByUserId(userId: String) async -> Result<[HistoryModel], Error> {
        let predicate = NSPredicate(format: "userId == %@", userId)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query)
            print("[CloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    HistoryModel(id: $0.recordID, problem: $0["problem"], rating: $0["rating"], feedback: $0["feedback"])
                }
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getAllHistory() async -> Result<[HistoryModel], Error> {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query)
            print("[CloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    HistoryModel(id: $0.recordID, problem: $0["problem"], rating: $0["rating"], feedback: $0["feedback"])
                }
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getHistory(id: CKRecord.ID) async -> Result<HistoryModel, Error> {
        let predicate = NSPredicate(format: "id == %@", id)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query, resultsLimit: 1)
            print("[CloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    HistoryModel(id: $0.recordID, problem: $0["problem"], rating: $0["rating"], feedback: $0["feedback"])
                }
            
            guard let history = data.first else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sound not found"])
            }
            
            return .success(history)
        } catch {
            return .failure(error)
        }
    }
    
    func saveHistory(history: HistoryModel) async -> Result<HistoryModel, Error> {
        let record = CKRecord(recordType: recordType.rawValue)
        record["problem"] = history.problem
        record["rating"] = history.rating
        record["feedback"] = history.feedback
        
        do {
            let result = try await cloudKitManager.saveData(record: record)
            
            return .success(
                HistoryModel(id: result.recordID, problem: history.problem, rating: history.rating, feedback: history.feedback)
            )
        } catch {
            return .failure(error)
        }
    }
}
