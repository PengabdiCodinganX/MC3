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
    
    @State var onboardingType: OnboardingType
    @State private var textList: [TextTrack] = []
    
    @Binding var isOnboardingFinished: Bool
    @Binding var isSignedIn: Bool
    
    var body: some View {
        print("render ulang")
        
        return ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Mascot(
                    mascotText: textList,
                    alignment: .vertical,
                    mascotContentMode: .scaleAspectFit
                )
                
                switch onboardingType {
                case .introduction:
                    IntroductionView(onboardingType: $onboardingType, textList: $textList)
                case .signIn:
                    SignInView(onboardingType: $onboardingType, isSignedIn: $isSignedIn, textList: $textList)
                case .permission:
                    PermissionView(isOnboardingFinished: $isOnboardingFinished)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {handleOnOnboardingTypeChanges()}
        .onChange(of: onboardingType, perform: { onboardingType in
            handleOnOnboardingTypeChanges()
        })
    }
    
    private func handleOnOnboardingTypeChanges() {
        switch onboardingType {
        case .introduction:
            textList = introductionData
        case .signIn:
            textList = []
        case .permission:
            textList = permissionData
        }
        
        print("[handleOnOnboardingTypeChanges][viewModel.isSignedIn()", viewModel.isSignedIn())
        guard viewModel.isSignedIn() else {
            print("[handleOnOnboardingTypeChanges][viewModel.isOnboardingFinished()", viewModel.isOnboardingFinished())
            guard viewModel.isOnboardingFinished() else {
                return
            }
            
            proceedToSignIn()
            return
        }
        
        guard !viewModel.isOnboardingFinished() else {
            return
        }
        
        proceedToPermissionPage()
    }
    
    func proceedToSignIn() {
        withAnimation(.spring()) {
            onboardingType = .signIn
        }
    }
    
    func proceedToPermissionPage() {
        withAnimation(.spring()) {
            onboardingType = .permission
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(
            onboardingType: .introduction,
            isOnboardingFinished: .constant(false),
            isSignedIn: .constant(false)
        )
    }
}
