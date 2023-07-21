//
//  SignInView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
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
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: OnboardingViewModel())
    }
}
