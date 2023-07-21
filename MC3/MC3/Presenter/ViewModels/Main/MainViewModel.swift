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
        appStorageService = AppStorageService()
    }
    
    func isOnboardingFinished() -> Bool {
        return appStorageService.isOnboardingFinished
    }
    
    func isSignedIn() -> Bool {
        appStorageService.isSignedIn()
    }
}
