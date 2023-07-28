//
//  SoundCloudKitService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 24/07/23.
//

import Foundation
import CloudKit

//class SoundCloudKitService {
//    private let cloudKitManager: CloudKitManager = CloudKitManager()
//    private  let recordType: RecordType = .sound
//    
//    func getAllSounds() async -> Result<[SoundModel], Error> {
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
//        
//        do {
//            let result = try await cloudKitManager.fetchData(query: query)
//            print("[CloudKitService][fetchApiKeyData][result]", result)
//            
//            let data = result.matchResults
//                .compactMap { _, result in try? result.get() }
//                .compactMap{
//                    SoundModel(id: $0.recordID, text: $0["text"], sound: $0["sound"])
//                }
//            
//            return .success(data)
//        } catch {
//            return .failure(error)
//        }
//    }
//    
//    func getSound(id: CKRecord.ID) async -> Result<SoundModel, Error> {
//        let predicate = NSPredicate(format: "id == %@", id)
//        let query = CKQuery(recordType: recordType.rawValue, predicate: predicate)
//        
//        do {
//            let result = try await cloudKitManager.fetchData(query: query, resultsLimit: 1)
//            print("[CloudKitService][fetchApiKeyData][result]", result)
//            
//            let data = result.matchResults
//                .compactMap { _, result in try? result.get() }
//                .compactMap{
//                    SoundModel(id: $0.recordID, text: $0["text"], sound: $0["sound"])
//                }
//            
//            guard let sound = data.first else {
//                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sound not found"])
//            }
//            
//            return .success(sound)
//        } catch {
//            return .failure(error)
//        }
//    }
//    
//    func saveSound(sound: SoundModel) async -> Result<SoundModel, Error> {
//        let record = CKRecord(recordType: recordType.rawValue)
//        record["text"] = sound.text
//        record["sound"] = sound.sound
//        
//        do {
//            let result = try await cloudKitManager.saveData(record: record)
//            
//            return .success(
//                SoundModel(id: result.recordID, text: sound.text, sound: sound.sound)
//            )
//        } catch {
//            return .failure(error)
//        }
//    }
//}
