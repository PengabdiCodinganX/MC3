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
    
    var body: some View {
        VStack {
            if viewModel.isOnboardingFinished && viewModel.isSignedIn {
                NavigationStack(path: $pathStore.path) {
                    HomeView()
                }
                .environmentObject(pathStore)
            } else {
                OnboardingView(onboardingType: viewModel.isOnboardingFinished ? .signIn : .introduction)
            }
        }
        .environmentObject(viewModel)
        .onChange(of: viewModel.isOnboardingFinished) { isOnboardingFinished in
            print("[isOnboardingFinished]", isOnboardingFinished)
            print("[viewModel.isSignedIn]", viewModel.isSignedIn)
        }
        .onAppear {
            Task {
                try? await ElevenLabsAPIService().fetchAPIKey()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
