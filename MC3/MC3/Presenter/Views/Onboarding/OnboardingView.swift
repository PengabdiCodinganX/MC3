//
//  OnboardingView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel = OnboardingViewModel()
    @EnvironmentObject var pathStore: PathStore
    
    @State var onboardingType: OnboardingType
    
    @State private var mascotText: String = "Hi there, You've come into the right place..."
    @State private var buttonType: ButtonType = .next
    
    var body: some View {
        VStack {
            Spacer()
            
            Mascot(
                text: mascotText,
                alignment: .vertical
            )
            
            switch onboardingType {
            case .introduction:
                EmptyView()
            case .signIn:
                SignInView(viewModel: viewModel)
            case .permission:
                PermissionView(viewModel: viewModel)
            }
            
            Spacer()
            
            if onboardingType == .introduction
                || onboardingType == .permission {
                HStack {
                    Spacer()
                    
                    PrimaryButton(text: buttonType.rawValue) {
                        handleOnClicked()
                    }
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(viewModel.error))
        }
        .onAppear {
            handleOnOnboardingTypeChanges()
        }
        .onChange(of: viewModel.authService.userIdentifier, perform: { _ in
            print("[viewModel.isSignedIn()]", viewModel.isSignedIn())
            handleOnOnboardingTypeChanges()})
        .onChange(of: onboardingType, perform: { _ in handleOnOnboardingTypeChanges()})
    }
    
    private func handleOnOnboardingTypeChanges() {
        guard viewModel.isSignedIn() else {
            guard viewModel.isOnboardingFinished else {
                return
            }
            
            proceedToSignIn()
            return
        }
        
        guard viewModel.isPermissionsAllowed() else {
            proceedToPermissionPage()
            return
        }
    }
    
    /// Handles next button clicked
    private func handleOnClicked() {
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
        // Check for permissions
        guard viewModel.isPermissionsAllowed() else {
            self.proceedToPermissionPage()
            return
        }
        
        viewModel.isOnboardingFinished = true
    }
    
    private func handleOnNextClicked() {
        withAnimation {
            buttonType = .getStarted
            mascotText = "I’m (Lion), your companion to discover the motivation you seek!"
        }
    }
    
    private func handleOnGetStartedClicked() {
        proceedToSignIn()
    }
    
    func proceedToSignIn() {
        withAnimation {
            onboardingType = .signIn
            mascotText = ""
        }
    }
    
    func proceedToPermissionPage() {
        withAnimation {
            onboardingType = .permission
            mascotText = "But before that, I would like you to set up some privacies. In order to make us close, what should I call you?"
            buttonType = .done
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingType: .introduction)
    }
}
