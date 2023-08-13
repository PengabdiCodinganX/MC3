//
//  StoryIntroductionViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import NaturalLanguage
import CloudKit

@MainActor
class StoryProblemViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    
    private let historyCloudKitService: HistoryCloudKitService = HistoryCloudKitService()
    private var userCloudKitService: UserCloudKitService = UserCloudKitService()
    private let nlpService: NLPService = NLPService()
    
    func getKeywordByText(text: String) -> [String] {
        return nlpService.generateSummary(for: text)
    }
    
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
    
    func saveHistory(problem: String) async throws -> HistoryModel? {
        let user = try await getUser()
        guard let userRecordID = user?.id else {
            print("user record not found.")
            // handle case when user id is nil
            return nil
        }
        
        let userReference = CKRecord.Reference(recordID: userRecordID, action: .none)
        
        print("[saveHistory][problem]", problem)
        let history: HistoryModel = HistoryModel(problem: problem, user: userReference)
        let result = await historyCloudKitService.saveHistory(history: history)
        
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            print("failure", failure)
            return nil
        }
    }
}
