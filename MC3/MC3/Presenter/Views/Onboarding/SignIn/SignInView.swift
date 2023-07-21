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
    @Binding var mascotText: String
    
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
            guard isSignedIn else {
                return
            }
            
            onboardingType = .permission
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(viewModel.error))
        }
    }
    

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(onboardingType: .constant(.signIn), mascotText: .constant("testasdcfas"))
    }
}
