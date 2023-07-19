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
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Mascot(
                    text: viewModel.mascotText,
                    alignment: (geometry.size.height <= 256) ? .horizontal : .vertical
                )

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
                    
                    Spacer()
                    
                    Toggle("Allow push notifications", isOn: $viewModel.isPushNotificationsPermissionToggled)
                        .onChange(of: viewModel.isPushNotificationsPermissionToggled, perform: viewModel.handleOnPushNotificationsPermissionToggled)
                    Toggle("Allow access mirophone", isOn: $viewModel.isMicrophonePermissionToggled)
                        .onChange(of: viewModel.isMicrophonePermissionToggled, perform: viewModel.handleOnMicrophonePermissionToggled)
                }
                
                Spacer()
                
                if viewModel.currentOnboardingType == .introduction
                    || viewModel.currentOnboardingType == .permission {
                    HStack {
                        Spacer()
                        
                        PrimaryButton(text: viewModel.buttonType.rawValue) {
                            viewModel.handleOnClicked()
                        }
                    }
                }
                
                if viewModel.isError {
                    Text(viewModel.error)
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
