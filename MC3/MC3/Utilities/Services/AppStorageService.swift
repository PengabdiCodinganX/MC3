//
//  AppStorageService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI

class AppStorageService {
    @AppStorage("userIdentifier") var userIdentifier: String = ""
    
    @AppStorage("isOnboardingFinished") var isOnboardingFinished: Bool = false
    @AppStorage("isPushNotificationPermissionAllowed") var isPushNotificationPermissionAllowed: Bool = false
    @AppStorage("isMicrophonePermissionAllowed") var isMicrophonePermissionAllowed = false
    
    /// Checks if the user is signed in.
    /// - Returns: Bool indicating whether the user is signed in.
    func isSignedIn() -> Bool {
        return !userIdentifier.isEmpty
    }
    
    func signIn(userIdentifier: String) {
        DispatchQueue.main.async {
            withAnimation {
                self.userIdentifier = userIdentifier
                print("[AppStorageService][signIn][self.userIdentifier]", self.userIdentifier)
            }
        }
    }
    
    func signOut() {
        DispatchQueue.main.async {
            withAnimation {
                self.userIdentifier = ""
            }
        }
    }
}
