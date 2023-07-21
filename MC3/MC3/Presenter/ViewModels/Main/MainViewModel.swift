//
//  SplashViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    private let authService: AuthService = AuthService()
    
    @AppStorage("isOnboardingFinished") var isOnboardingFinished: Bool = false
    
    func isSignedIn() -> Bool {
        authService.isSignedIn()
    }
}
