//
//  MyReflectionViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 28/07/23.
//

import Foundation
import CloudKit

class MyReflectionViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    private var historyCloudKitService: HistoryCloudKitService = HistoryCloudKitService()
    private var userCloudKitService: UserCloudKitService = UserCloudKitService()
    
    func getUser() async throws -> UserModel? {
        let userIdentifier = self.appStorageService.userIdentifier
        print("[PermissionViewModel][getUser][userIdentifier]", userIdentifier)
        
        let result = await self.userCloudKitService.getUser(userIdentifier: userIdentifier)
        switch result {
        case .success(let user):
            return user
        case .failure(let failure):
            print("failure", failure)
            return nil
        }
    }
    
    func getHistories() async throws -> [HistoryModel] {
        let user = try await getUser()
        guard let userRecordID = user?.id else {
            print("user record not found.")
            // handle case when user id is nil
            return []
        }
        
        let userReference = CKRecord.Reference(recordID: userRecordID, action: .none)
        let result = await historyCloudKitService.getAllHistoryByUser(user: userReference)
        print("[getHistories][result]", result)
        
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            return []
        }
    }
}
