//
//  SplashViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    private let appStorageService: AppStorageService
    
    @Published var isOnboardingFinished: Bool
    @Published var isSignedIn: Bool
    
    init() {
        self.appStorageService = AppStorageService()
        self.isOnboardingFinished = appStorageService.isOnboardingFinished
        self.isSignedIn = appStorageService.isSignedIn()
    }
    
    func setOnboardingFinished(_ state: Bool) {
        withAnimation(.spring()) {
            self.isOnboardingFinished = state
            self.appStorageService.isOnboardingFinished = state
            
            self.isSignedIn = appStorageService.isSignedIn()
        }
    }
    
    func setSignedIn(_ state: Bool) {
        withAnimation {
            self.isSignedIn = state
        }
    }
    
    func signOut() {
        self.appStorageService.signOut()
        self.isSignedIn = appStorageService.isSignedIn()
    }
}
