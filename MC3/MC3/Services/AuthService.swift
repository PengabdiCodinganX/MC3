//
//  AuthService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI

class AuthService: ObservableObject {
    @AppStorage("userIdentifier") var userIdentifier: String = ""
    
    /// Checks if the user is signed in.
    /// - Returns: Bool indicating whether the user is signed in.
    func isSignedIn() -> Bool {
        return !userIdentifier.isEmpty
    }
    
    func signOut() {
        userIdentifier = ""
    }
}
