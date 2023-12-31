//
//  MainView.swift
//  MC3
//
//  Created by Vincent Gunawan on 11/07/23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel = MainViewModel()
    @StateObject private var pathStore: PathStore = PathStore()
    
    @State var isOnboardingFinished: Bool = false
    @State var isSignedIn: Bool = false
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            if isOnboardingFinished && isSignedIn {
                HomeView(isSignedIn: $isSignedIn)
            } else {
                OnboardingFirstView(
                    
                    isSignedIn: $isSignedIn,
                    isOnboardingFinished: $isOnboardingFinished
                    //                    isOnboardingFinished: self.$isOnboardingFinished,
                    //                    isSignedIn: self.$isSignedIn
                )
//                OnboardingView(
//                    onboardingType: self.getOnboardingType(),
//                    isOnboardingFinished: self.$isOnboardingFinished,
//                    isSignedIn: self.$isSignedIn
//                )
            }
        }
        .environmentObject(pathStore)
        .environmentObject(viewModel)
        .onAppear {
            print("[MainView][viewModel.isOnboardingFinished()]", viewModel.isOnboardingFinished())
            print("[MainView][viewModel.isSignedIn()]", viewModel.isSignedIn())
            
            self.isOnboardingFinished = viewModel.isOnboardingFinished()
            self.isSignedIn = viewModel.isSignedIn()
        }
        .onChange(of: isOnboardingFinished) { isOnboardingFinished in
            viewModel.setOnboardingFinished(isOnboardingFinished)
        }
        .onChange(of: isSignedIn) { isSignedIn in
            print("[MainView][isSignedIn]", isSignedIn)
            if !isSignedIn {
                viewModel.signOut()
            }
        }
    }
    
    func getOnboardingType() -> OnboardingType {
        return viewModel.isOnboardingFinished() ? .signIn : .introduction
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
