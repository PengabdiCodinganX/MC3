//
//  SignInView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @StateObject private var viewModel: SignInViewModel = SignInViewModel()

    @Binding var onboardingType: OnboardingType
    @Binding var isSignedIn: Bool
    @Binding var textList: [TextTrack]
    
    var body: some View {
        VStack {
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
        .onChange(of: viewModel.isSignedIn) { isSignedIn in
            withAnimation(.spring()) {
                self.isSignedIn = isSignedIn
            }
                
            guard isSignedIn else {
                return
            }
            
            proceedToPermissionPage()
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(viewModel.error))
        }
    }
    
    func proceedToPermissionPage() {
        withAnimation(.spring()) {
            onboardingType = .permission
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(onboardingType: .constant(.signIn), isSignedIn: .constant(false), textList: .constant([]))
    }
}
