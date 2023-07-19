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
    
    var body: some View {
        VStack {
            Spacer()

            if !viewModel.mascotText.isEmpty {
                BubbleText(text: viewModel.mascotText)
            }

            Image("Mascot")
            
            if (viewModel.currentOnboardingType == .signIn) {
                TitleText(text: "Welcome to App Name")
                    .padding()
                BodyText(text: "Sign in now to embark on your journey and unlock the motivation you've been searching for.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                    SignInWithAppleButton(.signIn,
                                          onRequest: viewModel.handleOnSignInRequest,
                                          onCompletion: viewModel.handleOnSignInCompletion)
                    .signInWithAppleButtonStyle(.whiteOutline)
                    .frame(height: 48)
                    .padding()
            }
            
            if (viewModel.currentOnboardingType == .permission) {
                SingleTextField(placeholder: "Name...", text: $viewModel.name)
                
                Toggle("Allow push notifications", isOn: $viewModel.isPushNotificationsPermissionAllowed)
                Toggle("Allow access mirophone", isOn: $viewModel.isMicrophonePermissionAllowed)
            }

            Spacer()

            if viewModel.currentOnboardingType == .introduction
                || viewModel.currentOnboardingType == .permission {
                HStack {
                    Spacer()
                    
                    PrimaryButton(text: viewModel.buttonText) {
                        viewModel.handleOnClicked()
                    }
                }
            }
            
        }
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
