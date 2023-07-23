//
//  SplashViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    private let appStorageService: AppStorageService
    
    init() {
        self.appStorageService = AppStorageService()
    }
    
    func isOnboardingFinished() -> Bool {
        return appStorageService.isOnboardingFinished
    }
    
    func setOnboardingFinished(_ state: Bool) {
        self.appStorageService.isOnboardingFinished = state
    }
    
    func isSignedIn() -> Bool {
        return appStorageService.isSignedIn()
    }
    
    func signOut() {
        self.appStorageService.signOut()
    }
}
