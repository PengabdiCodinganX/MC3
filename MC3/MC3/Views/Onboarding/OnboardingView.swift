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
    
    var body: some View {
        VStack {
            Spacer()
            
            Mascot(
                text: viewModel.mascotText,
                alignment: .vertical
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
        .padding()
        .onAppear {
            print("[OnboardingView][viewModel.userIdentifier]", viewModel.userIdentifier)
            print("[OnboardingView][viewModel.isOnboardingFinished]", viewModel.isOnboardingFinished)
            guard !viewModel.isOnboardingFinished else {
                guard viewModel.isSignedIn() else {
                    viewModel.proceedToSignIn()
                    return
                }
                
                pathStore.path.append(ViewPath.home)
                return
            }
            
            guard viewModel.isSignedIn() else {
                print("[OnboardingView][userIdentifier]", viewModel.userIdentifier)
                guard viewModel.isMicrophonePermissionAllowed else {
                    print("[viewModel.isMicrophonePermissionAllowed]", viewModel.isMicrophonePermissionAllowed)
                    viewModel.proceedToPermissionPage()
                    return
                }
                
                guard viewModel.isPushNotificationsPermissionAllowed else {
                    print("[viewModel.isPushNotificationsPermissionAllowed]", viewModel.isPushNotificationsPermissionAllowed)
                    viewModel.proceedToPermissionPage()
                    return
                }
                
                print("[done]")
                pathStore.path.append(ViewPath.home)
                return
            }
        }
        .onChange(of: viewModel.isOnboardingFinished) { isOnboardingFinished in
            print("[OnboardingView][isOnboardingFinished]", isOnboardingFinished)
            if isOnboardingFinished {
                pathStore.path.append(ViewPath.home)
            }
        }
        .onChange(of: viewModel.userIdentifier) { userIdentifier in
            print("[OnboardingView][userIdentifier]", userIdentifier)
            guard !userIdentifier.isEmpty else {
                print("[!userIdentifier.isEmpty]", !userIdentifier.isEmpty)
                return
            }
            
            guard viewModel.isMicrophonePermissionAllowed else {
                print("[viewModel.isMicrophonePermissionAllowed]", viewModel.isMicrophonePermissionAllowed)
                viewModel.proceedToPermissionPage()
                return
            }
            
            guard viewModel.isPushNotificationsPermissionAllowed else {
                print("[viewModel.isPushNotificationsPermissionAllowed]", viewModel.isPushNotificationsPermissionAllowed)
                viewModel.proceedToPermissionPage()
                return
            }
            
            print("[done]")
            pathStore.path.append(ViewPath.home)
        }
        .navigationDestination(for: ViewPath.self) { viewPath in
            HomeView()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
