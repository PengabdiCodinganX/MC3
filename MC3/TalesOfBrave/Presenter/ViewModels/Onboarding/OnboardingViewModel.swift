//
//  OnboardingViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import Foundation
import CoreData
import SwiftUI
import AuthenticationServices
import AVFoundation
import UserNotifications

@MainActor
class OnboardingViewModel: ObservableObject {
    private let appStorageService: AppStorageService
    
    init() {
        appStorageService = AppStorageService()
    }
    
    /// Checks if the user is signed in.
    /// - Returns: Bool indicating whether the user is signed in.
    func isSignedIn() -> Bool {
        return appStorageService.isSignedIn()
    }
    
    func isOnboardingFinished() -> Bool {
        return appStorageService.isOnboardingFinished
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
}
