//
//  SignInViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import AuthenticationServices

class SignInViewModel: ObservableObject {
    private let db: UserUseCase
    private let appStorageService: AppStorageService
    
    @Published var error: String = ""
    
    @Published var isSignedIn: Bool = false
    @Published var isError: Bool = false
    
    init() {
        self.db = Injec().user()
        self.appStorageService = AppStorageService()
    }
    
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
        
        // User exist
        let user = db.getUser(userIdentifier: userIdentifier)
        switch user {
        case .success(_):
            handleSignIn(userIdentifier)
            break
        case .failure(_): break
        }
        
        // User doesn't exist
        let result = saveNewUser(appleIDCredential)
        switch result {
        case .success(_):
            handleSignIn(userIdentifier)
            break
        case .failure(let error):
            setError(error.localizedDescription)
            break
        }
    }
    
    /// Saves a new user with given AppleID credentials.
    /// - Parameter appleIDCredential: ASAuthorizationAppleIDCredential object with user details.
    private func saveNewUser(_ appleIDCredential: ASAuthorizationAppleIDCredential) -> Result<UserModel, Error> {
        let userIdentifier = appleIDCredential.user
        let email = appleIDCredential.email
        let name = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
        
        let user: UserModel = UserModel(
            id: UUID(),
            userIdentifier: userIdentifier,
            email: email,
            name: name
        )
        
        return self.db.saveUser(user: user)
    }
    
    /// Sets the userIdentifier.
    private func handleSignIn(_ userIdentifier: String) {
        self.appStorageService.signIn(userIdentifier: userIdentifier)
        isSignedIn = true
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
