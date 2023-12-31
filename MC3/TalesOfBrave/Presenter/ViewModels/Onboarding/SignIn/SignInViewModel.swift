//
//  SignInViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import SwiftUI
import AuthenticationServices

@MainActor
class SignInViewModel: ObservableObject {
    private let userCloudKitService: UserCloudKitService = UserCloudKitService()
    private let appStorageService: AppStorageService = AppStorageService()
    
    @Published var error: String = ""
    
    @Published var isSignedIn: Bool = false
    @Published var isError: Bool = false
    
    /// Configures the sign in request
    func handleOnSignInRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    /// Initiates sign in process with the given result.
    /// - Parameter result: Result object containing either ASAuthorization or Error.
    func handleOnSignInCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                self.handleOnSignInSuccess(appleIDCredential)
            default:
                break
            }
        case .failure(let error):
            // Handle error
            print("Error authenticating: \(error.localizedDescription)")
            self.handleOnSignInFailure(error: error)
        }
    }
    
    /// Handles the sign in success event.
    /// - Parameter appleIDCredential: ASAuthorizationAppleIDCredential object with user details.
    private func handleOnSignInSuccess(_ appleIDCredential: ASAuthorizationAppleIDCredential) {
        let userIdentifier = appleIDCredential.user
        
        Task {
            // User exist
            let user = await self.userCloudKitService.getUser(userIdentifier: userIdentifier)
            switch user {
            case .success(_):
                handleSignIn(userIdentifier)
                break
            case .failure(_): break
            }
            
            // User doesn't exist
            let result = await saveNewUser(appleIDCredential)
            switch result {
            case .success(_):
                handleSignIn(userIdentifier)
                break
            case .failure(let error):
                setError(error.localizedDescription)
                break
            }
        }
    }
    
    /// Saves a new user with given AppleID credentials.
    /// - Parameter appleIDCredential: ASAuthorizationAppleIDCredential object with user details.
    private func saveNewUser(_ appleIDCredential: ASAuthorizationAppleIDCredential) async -> Result<UserModel, Error> {
        let userIdentifier = appleIDCredential.user
        let email = appleIDCredential.email
        let name = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
        
        let user: UserModel = UserModel(
            userIdentifier: userIdentifier,
            email: email,
            name: name
        )
        
        return await self.userCloudKitService.saveUser(user: user)
    }
    
    /// Sets the userIdentifier.
    private func handleSignIn(_ userIdentifier: String) {
        Task {
            self.appStorageService.signIn(userIdentifier: userIdentifier)
        }
        
        withAnimation(.spring()) {
            self.isSignedIn = true
        }
    }
    
    /// Handles sign in failure event.
    /// - Parameter error: The occurred error.
    private func handleOnSignInFailure(error: Error) {
        self.setError(error.localizedDescription)
    }
    
    private func setError(_ error: String) {
        isError = true
        self.error = error
    }
}
