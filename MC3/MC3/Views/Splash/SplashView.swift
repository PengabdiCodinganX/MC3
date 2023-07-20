//
//  SplashView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel = SplashViewModel()
    @EnvironmentObject var pathStore: PathStore
    
    var body: some View {
        Mascot(
            text: "",
            alignment: .vertical
        )
        .padding()
        .onAppear {
            if viewModel.isSignedIn() {
                proceedToHome()
            } else {
                proceedToOnboarding()
            }
        }
        .navigationDestination(for: ViewPath.self) { viewPath in
            switch viewPath {
            case .onboarding:
                OnboardingView()
            case .home:
                HomeView()
            }
        }
    }
    
    func proceedToHome() {
        pathStore.proceedToHome()
    }
    
    func proceedToOnboarding() {
        pathStore.proceedToOnboarding()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
