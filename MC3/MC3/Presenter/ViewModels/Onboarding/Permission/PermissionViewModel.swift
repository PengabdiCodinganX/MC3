//
//  PermissionViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI
import UserNotifications
import AVFAudio

@MainActor
class PermissionViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    private let userCoreDataService: UserCoreDataService = UserCoreDataService()
    
    @Published var isPushNotificationPermissionAllowed: Bool = false
    @Published var isMicrophonePermissionAllowed: Bool = false
    
    @Published var user: UserModel = UserModel()
    @Published var name: String = ""
    
    @Published var isError: Bool = false
    @Published var error: String = ""
    
    init() {
        self.getUser()
    }
    
    func getUser() {
        Task {
            print("[PermissionViewModel][getUser]")
            let userIdentifier = self.appStorageService.userIdentifier
            print("[PermissionViewModel][getUser][userIdentifier]", userIdentifier)
            
            let result = self.userCoreDataService.getUser(userIdentifier: userIdentifier)
            switch result {
            case .success(let user):
                print("[PermissionViewModel][getUser][user]", user)
                self.user = user
                self.name = user.name ?? ""
            case .failure(let error):
                setError(error: error.localizedDescription)
            }
        }
    }
    
    func isPermissionsAllowed() -> Bool {
        // Check for permissions
        guard appStorageService.isPushNotificationPermissionAllowed else {
            return false
        }
        
        guard appStorageService.isMicrophonePermissionAllowed else {
            return false
        }
        
        return true
    }
    
    func setError(error: String) {
        self.error = error
        self.isError = true
    }
    
    func handleOnPushNotificationsPermissionToggled(_ isOn: Bool) {
        if isOn {
            // Request permission for push notifications if not yet granted.
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                withAnimation(.spring()) {
                    self.appStorageService.isPushNotificationPermissionAllowed = granted
                    
                    Task {
                        await MainActor.run {
                            self.isPushNotificationPermissionAllowed = granted
                        }
                    }
                }
            }
        } else {
            print("Push notification permission toggle is off.")
        }
    }

    func handleOnMicrophonePermissionToggled(_ isOn: Bool) {
        if isOn {
            // Request permission for microphone if not yet granted.
            AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
                withAnimation(.spring()) {
                    self.appStorageService.isMicrophonePermissionAllowed = granted
                    
                    Task {
                        await MainActor.run {
                            self.isMicrophonePermissionAllowed = granted
                        }
                    }
                }
            }
        } else {
            print("Microphone permission toggle is off.")
        }
    }
}
