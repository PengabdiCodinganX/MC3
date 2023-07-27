//
//  UserCloudKitService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 25/07/23.
//

import Foundation
import CloudKit

class UserCloudKitService {
    private let cloudKitManager: CloudKitManager = CloudKitManager()
    private  let recordType: RecordType = .user
    
    func getAllUser() async -> Result<[UserModel], Error> {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query)
            print("[CloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    UserModel(id: $0.recordID, userIdentifier: $0["userIdentifier"], email: $0["email"], name: $0["name"])
                }
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getUserRecord(userIdentifier: String) async -> Result<CKRecord, Error> {
        let predicate = NSPredicate(format: "userIdentifier == %@", userIdentifier)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query, resultsLimit: 1)
            print("[CloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }

            guard let user = data.first else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
            }
            
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    func getUser(userIdentifier: String) async -> Result<UserModel, Error> {
        let predicate = NSPredicate(format: "userIdentifier == %@", userIdentifier)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query, resultsLimit: 1)
            print("[CloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    UserModel(id: $0.recordID, userIdentifier: $0["userIdentifier"], email: $0["email"], name: $0["name"])
                }
            
            guard let user = data.first else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
            }
            
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    func getUser(id: CKRecord.ID) async -> Result<UserModel, Error> {
        let predicate = NSPredicate(format: "id == %@", id)
        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
        
        do {
            let result = try await cloudKitManager.fetchData(query: query, resultsLimit: 1)
            print("[CloudKitService][fetchApiKeyData][result]", result)
            
            let data = result.matchResults
                .compactMap { _, result in try? result.get() }
                .compactMap{
                    UserModel(id: $0.recordID, userIdentifier: $0["userIdentifier"], email: $0["email"], name: $0["name"])
                }
            
            guard let user = data.first else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
            }
            
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    func saveUser(user: UserModel) async -> Result<UserModel, Error> {
        let record = CKRecord(recordType: recordType.rawValue)
        record["userIdentifier"] = user.userIdentifier
        record["email"] = user.email
        record["name"] = user.name

        do {
            let result = try await cloudKitManager.saveData(record: record)
            
            return .success(
                UserModel(id: result.recordID, userIdentifier: user.userIdentifier, email: user.email, name: user.name)
            )
        } catch {
            return .failure(error)
        }
    }
}
