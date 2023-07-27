//
//  HomeViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import Foundation
import SwiftUI
import AVFAudio

@MainActor
class HomeViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    private let userCloudKitService: UserCloudKitService = UserCloudKitService()

    @Published var dailyMotivation: String = ""
    
    @Published var isError: Bool = false
    @Published var error: String = ""
    
    func getUser() async -> UserModel? {
            print("[PermissionViewModel][getUser]")
            let userIdentifier = self.appStorageService.userIdentifier
            print("[PermissionViewModel][getUser][userIdentifier]", userIdentifier)
            
            let result = await self.userCloudKitService.getUser(userIdentifier: userIdentifier)
            switch result {
            case .success(let user):
                print("[PermissionViewModel][getUser][user]", user)
                return user
            case .failure(let error):
                setError(error: error.localizedDescription)
                return nil
            }
    }
    
    func setError(error: String) {
        self.error = error
        self.isError = true
    }
    
    func getDailyMotivation() {
        //  TODO
    }
}
