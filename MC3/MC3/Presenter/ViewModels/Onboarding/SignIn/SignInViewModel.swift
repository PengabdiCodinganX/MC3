//
//  SignInViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import AuthenticationServices

class SignInViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    
    @Published var authService: AuthService = AuthService()
    
    @Published var isSignedIn: Bool = false
    
    @Published var isError: Bool = false
    
    /// Contains any error message related to sign-in operations
    @Published var error: String = ""
    
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
        
        // User already exists
        if (userIdentifier) != nil {
            handleSignIn(userIdentifier)
            return
        }
        
        // User doesn't exist
        saveNewUser(appleIDCredential)
    }
    
    /// Saves a new user with given AppleID credentials.
    /// - Parameter appleIDCredential: ASAuthorizationAppleIDCredential object with user details.
    private func saveNewUser(_ appleIDCredential: ASAuthorizationAppleIDCredential) {
        let userIdentifier = appleIDCredential.user
        let email = appleIDCredential.email
        let name = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
        
        let user = User(context: viewContext)
        user.id = UUID()
        user.userIdentifier = userIdentifier
        user.email = email
        user.name = name
        
        do {
            try viewContext.save()
        } catch {
            // Handle error
            setError("Failed to save user.")
        }
        
        handleSignIn(userIdentifier)
    }
    
    /// Sets the userIdentifier.
    private func handleSignIn(_ userIdentifier: String) {
        
            self.authService.signIn(userIdentifier: userIdentifier)
            print("[handleSignIn][userIdentifier]", userIdentifier)
            
            print("[handleSignIn][authService.userIdentifier]", self.authService.userIdentifier)
            print("[handleSignIn][authService.isSignedIn()]", self.authService.isSignedIn())
        
    }
    
    /// Handles sign in failure event.
    /// - Parameter error: The occurred error.
    private func handleOnSignInFailure(error: Error) {
        self.setError(error.localizedDescription)
    }
    
    private func setError(error: String) {
        isError = true
        self.error = error
    }
}
