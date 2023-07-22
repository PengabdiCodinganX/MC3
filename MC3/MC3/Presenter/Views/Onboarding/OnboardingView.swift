//
//  OnboardingView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @EnvironmentObject private var mainViewModel: MainViewModel
    @StateObject private var viewModel: OnboardingViewModel = OnboardingViewModel()
    
    @State var onboardingType: OnboardingType
    @State private var mascotText: String = "Hi there, You've come into the right place..."
    
    var body: some View {
        VStack {
            Spacer()
            
            Mascot(
                text: mascotText,
                alignment: .vertical
            )
            
            switch onboardingType {
            case .introduction:
                IntroductionView(onboardingType: $onboardingType, mascotText: $mascotText)
            case .signIn:
                SignInView(onboardingType: $onboardingType, mascotText: $mascotText)
            case .permission:
                PermissionView()
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onAppear {handleOnOnboardingTypeChanges()}
        .onChange(of: onboardingType, perform: { _ in handleOnOnboardingTypeChanges()})
    }
    
    private func handleOnOnboardingTypeChanges() {
        guard viewModel.isSignedIn() else {
            guard viewModel.isOnboardingFinished() else {
                return
            }
            
            proceedToSignIn()
            return
        }
        
        guard !viewModel.isOnboardingFinished() else {
            mainViewModel.isSignedIn = true
            return
        }
        
        proceedToPermissionPage()
    }
    
    func proceedToSignIn() {
        withAnimation(.spring()) {
            onboardingType = .signIn
            mascotText = ""
        }
    }
    
    func proceedToPermissionPage() {
        withAnimation(.spring()) {
            onboardingType = .permission
            mascotText = "But before that, I would like you to set up some privacies. In order to make us close, what should I call you?"
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingType: .introduction)
    }
}
