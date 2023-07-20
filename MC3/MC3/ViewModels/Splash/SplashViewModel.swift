//
//  SplashViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI

class SplashViewModel: ObservableObject {
    func isSignedIn() -> Bool {
        AuthService().isSignedIn()
    }
}
