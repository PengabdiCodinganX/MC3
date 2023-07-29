//
//  StoryIntroductionView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct ValidateProblemView: View {
    let onContinue: () -> Void
    let onDismiss: () -> Void
    
    var body: some View {
        
        PrimaryButton(text: " Continue ", isFull: true) {
            onContinue()
        }
        
        SecondaryButton(text: "Not now", isFull: true) {
            onDismiss()
        }
    }
}

struct ValidateFeelingView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateProblemView(onContinue: {}, onDismiss: {})
    }
}
