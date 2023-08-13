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
    @Binding var textList: [TextTrack]
    
    
    var body: some View {
        Spacer()
        
        HStack(alignment: .bottom) {
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
        withAnimation(.spring()) {
            buttonType = .getStarted
        }
    }
    
    private func handleOnGetStartedClicked() {
        withAnimation(.spring()) {
            onboardingType = .signIn
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView(onboardingType: .constant(.introduction), textList: .constant([]))
    }
}
