//
//  ReflectionViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import CloudKit

class ReflectionViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    
    private var userCloudKitService: UserCloudKitService = UserCloudKitService()
    private var historyCloudKitService: HistoryCloudKitService = HistoryCloudKitService()
    
    @Published private var user: UserModel?
    
    init() {
        self.getUser()
    }
    
    func getUser() {
        Task {
            print("[ReflectionViewModel][getUser]")
            let userIdentifier = self.appStorageService.userIdentifier
            print("[ReflectionViewModel][getUser][userIdentifier]", userIdentifier)
            
            let result = await self.userCloudKitService.getUser(userIdentifier: userIdentifier)
            switch result {
            case .success(let user):
                print("[ReflectionViewModel][getUser][user]", user)
                self.user = user
            case .failure(_): break
//                setError(error: error.localizedDescription)
            }
        }
    }
    
    func saveHistory(problem: String, story: StoryModel) async {
        guard let userRecordID = user?.id else {
            // handle case when user id is nil
            return
        }
        
        let userReference = CKRecord.Reference(recordID: userRecordID, action: .none)
                
        let history = HistoryModel(problem: problem)
        
        await historyCloudKitService.saveHistory(history: history)
    }
}
