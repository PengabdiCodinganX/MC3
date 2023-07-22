//
//  CloudKitService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 22/07/23.
//

import Foundation
import CloudKit

class CloudKitService: ObservableObject {
    private let container: CKContainer
    private let database: CKDatabase

    init() {
        container = CKContainer(identifier: "iCloud.com Mincent-Gunawan.MC3")
        database = container.publicCloudDatabase
    }
    
    func getAPIKey(name: String)
    
    func fetchAuthorizationKey(recordName: String, completion: @escaping (Result<String, Error>) -> Void) {
         let recordID = CKRecord.ID(recordName: recordName)
         
         database.fetch(withRecordID: recordID) { result, error in
             if let error = error {
                 print(error.localizedDescription)
                 completion(.failure(error))
                 return
             }
             
             guard let result = result, let key = result["AuthorizationKey"] as? String else {
                 completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                 return
             }
             
             completion(.success(key))
         }
     }
}
