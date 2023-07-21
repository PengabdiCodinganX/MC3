//
//  MainView.swift
//  MC3
//
//  Created by Vincent Gunawan on 11/07/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var pathStore: PathStore = PathStore()
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isOnboardingFinished
            && viewModel.isSignedIn() {
            NavigationStack(path: $pathStore.path) {
                HomeView()
            }
            .environmentObject(pathStore)
            .navigationDestination(
                for: ViewPath.self) { viewPath in
                    switch viewPath {
                    case .home:
                        HomeView()
                    case .onboarding:
                        OnboardingView(onboardingType: .introduction)
                    }
                }
        } else {
            OnboardingView(onboardingType: viewModel.isOnboardingFinished
                           ? .signIn
                           : .introduction
            )
            .onAppear {
                print("isonboard", viewModel.isOnboardingFinished)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
