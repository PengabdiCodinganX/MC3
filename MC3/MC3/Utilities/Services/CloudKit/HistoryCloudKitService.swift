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
                    HistoryModel(
                        id: $0.recordID,
                        problem: $0["problem"],
                        reflection: $0["reflection"],
                        user: $0["user"],
                        story: $0["story"],
                        rating: $0["rating"]
                    )
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
                    HistoryModel(
                        id: $0.recordID,
                        problem: $0["problem"],
                        reflection: $0["reflection"],
                        user: $0["user"],
                        story: $0["story"],
                        rating: $0["rating"]
                    )
                }
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getHistory(id: CKRecord.ID) async -> Result<HistoryModel, Error> {
        do {
            let data = try await cloudKitManager.fetchData(recordID: id)
            print("[CloudKitService][fetchApiKeyData][result]", data)
            
            return .success(
                HistoryModel(
                    id: data.recordID,
                    problem: data["problem"],
                    reflection: data["reflection"],
                    user: data["user"],
                    story: data["story"],
                    rating: data["rating"]
                )
            )
        } catch {
            return .failure(error)
        }
    }
    
    func getHistoryRecord(id: CKRecord.ID) async -> Result<CKRecord, Error> {
        do {
            let data = try await cloudKitManager.fetchData(recordID: id)
            print("[CloudKitService][fetchApiKeyData][result]", data)
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func saveHistory(history: HistoryModel) async -> Result<HistoryModel, Error> {
        let record = CKRecord(recordType: recordType.rawValue)
        record["problem"] = history.problem
        record["rating"] = history.rating
        record["reflection"] = history.reflection
        record["user"] = history.user
        record["story"] = history.story
        record["rating"] = history.rating
        
        do {
            let result = try await cloudKitManager.saveData(record: record)
            
            return .success(
                HistoryModel(
                    id: result.recordID,
                    problem: history.problem,
                    reflection: history.reflection,
                    user: history.user,
                    story: history.story,
                    rating: history.rating
                )
            )
        } catch {
            return .failure(error)
        }
    }
    
    func updateHistory(history: HistoryModel) async -> Result<HistoryModel, Error> {
        guard let recordID = history.id else {
            return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Record ID not found."]))
        }
        
        let result = await getHistoryRecord(id: recordID)
        switch result {
        case .success(let record):
            record["problem"] = history.problem
            record["rating"] = history.rating
            record["reflection"] = history.reflection
            record["user"] = history.user
            record["story"] = history.story
            record["rating"] = history.rating
     
            do {
                let result = try await cloudKitManager.saveData(record: record)
                
                return .success(
                    HistoryModel(
                        id: result.recordID,
                        problem: history.problem,
                        reflection: history.reflection,
                        user: history.user,
                        story: history.story,
                        rating: history.rating
                    )
                )
            } catch {
                return .failure(error)
            }
        case .failure(let failure):
            print("failure", failure)
            return .failure(failure)
        }
    }
}
