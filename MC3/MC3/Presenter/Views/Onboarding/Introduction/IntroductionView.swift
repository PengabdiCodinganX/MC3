//
//  IntroductionView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import SwiftUI

struct IntroductionView: View {
    @State private var buttonType: ButtonType = .next
    
    @Binding var onboardingType: OnboardingType
    @Binding var mascotText: String
    
    var body: some View {
        HStack {
            Spacer()
            
            PrimaryButton(text: buttonType.rawValue) {
                handleOnClicked()
            }
        }
    }
    
    /// Handles next button clicked
    private func handleOnClicked() {
        switch buttonType {
        case .next:
            self.handleOnNextClicked()
        case .getStarted:
            self.handleOnGetStartedClicked()
        case .done: break
        }
    }
    
    private func handleOnNextClicked() {
        withAnimation {
            buttonType = .getStarted
            mascotText = "I’m (Lion), your companion to discover the motivation you seek!"
        }
    }
    
    private func handleOnGetStartedClicked() {
        onboardingType = .signIn
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView(onboardingType: .constant(.introduction), mascotText: .constant("test"))
    }
}
