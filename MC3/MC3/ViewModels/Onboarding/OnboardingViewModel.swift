//
//  OnboardingViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import Foundation
import CoreData
import SwiftUI
import AuthenticationServices

class OnboardingViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    
    // Unique identifier for the signed in user
    @AppStorage("isOnboardingIntroductionFinished") var isOnboardingIntroductionFinished: Bool = false
    
    // Unique identifier for the signed in user
    @AppStorage("isOnboardingPermissionFinished") var isOnboardingPermissionFinished: Bool = false
    
    @AppStorage("isPushNotificationsPermissionAllowed") var isPushNotificationsPermissionAllowed: Bool = false
    @AppStorage("isMicrophonePermissionAllowed") var isMicrophonePermissionAllowed: Bool = false
    
    // Unique identifier for the signed in user
    @AppStorage("userIdentifier") var userIdentifier: String = ""
    
    /// Contains the current onboarding being displayed
    @Published var currentOnboardingType: OnboardingType = .introduction
    
    /// Contains the current state of the button
    @Published var buttonType: ButtonType = .next
    
    /// Contains the current button text
    @Published var buttonText: String = "Next"
    
    /// Contains the current mascot text being displayed
    @Published var mascotText: String = "Hi there, You've come into the right place..."
    
    @Published var name: String = ""
    
    // Contains any error message related to sign-in operations
    @Published var error: String = ""
    
    /// Handles next button clicked
    func handleOnClicked() {
        switch buttonType {
        case .next:
            self.handleOnNextClicked()
        case .getStarted:
            self.handleOnGetStartedClicked()
    case .done:
        self.handleOnDoneClicked()
        }


    }

private func handleOnDoneClicked() {
    withAnimation {
        // TODO
    }
}
    
    private func handleOnNextClicked() {
            withAnimation {
                setCurrentIntroductionButtonType(.getStarted)
                setCurrentIntroductionButtonText("Get Started")
                setMascotText("I’m (Lion), your companion to discover the motivation you seek!")
            }
    }
    
    private func handleOnGetStartedClicked() {
        withAnimation(.spring()) {
//            setMascotText("")
//            setCurrentOnboardingType(.signIn)
            
            setCurrentOnboardingType(.permission)
            setMascotText("But before that, I would like you to set up some privacies. In order to make us close, what should I call you?")
            setName("test")
        }
        
        isOnboardingIntroductionFinished = true
    }
    
    private func setCurrentIntroductionButtonText(_ text: String) {
        self.buttonText = text
    }
    
    private func setCurrentIntroductionButtonType(_ introductionButtonType: ButtonType) {
        self.buttonType = introductionButtonType
    }
    
    /// Checks if the user is signed in.
    /// - Returns: Bool indicating whether the user is signed in.
    func isSignedIn() -> Bool {
        return !userIdentifier.isEmpty
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
        
        // User already exists
        if getUserByUserIdentifier(userIdentifier) != nil {
            signIn(userIdentifier)
            return
        }
        
        guard appleIDCredential.email != nil else {
            // Handle cases where email is not provided. This depends on your specific needs.
            setError("An email address is required for signing in.")
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
        
        signIn(userIdentifier)
        

    }
    
    /// Sets the userIdentifier.
    private func signIn(_ userIdentifier: String) {
        self.userIdentifier = userIdentifier
    }
    
    /// Handles sign in failure event.
    /// - Parameter error: The occurred error.
    private func handleOnSignInFailure(error: Error) {
        self.setError(error.localizedDescription)
    }
    
    private func setMascotText(_ text: String) {
        self.mascotText = text
    }
    
    private func setCurrentOnboardingType(_ onboardingType: OnboardingType) {
        self.currentOnboardingType = onboardingType
    }
    
    /// Returns a User object matching the given userIdentifier, if any.
    /// - Parameter userIdentifier: User identifier string.
    /// - Returns: User object or nil if no match found.
    private func getUserByUserIdentifier(_ userIdentifier: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userIdentifier == %@", userIdentifier)
        
        do {
            let fetchedUsers = try viewContext.fetch(fetchRequest)
            return fetchedUsers.first
        } catch {
            // Handle error
            setError("Failed to fetch user.")
            return nil
        }
    }
    
    /// Updates the error message.
    /// - Parameter error: Error message string.
    private func setError(_ error: String) {
        print("[setError][error]", error)
        self.error = error
    }
    
    private func setName(_ name: String) {
        self.name = name
    }
}
