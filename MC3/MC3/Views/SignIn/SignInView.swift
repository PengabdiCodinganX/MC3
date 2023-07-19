//
//  SignInView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 16/07/23.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInView: View {
    /// ViewModel instance for sign-in operations.
    @StateObject private var viewModel: SignInViewModel = SignInViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Image("Mascot")
            
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
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
