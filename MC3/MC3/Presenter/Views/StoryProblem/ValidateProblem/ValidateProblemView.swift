//
//  StoryIntroductionView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct ValidateProblemView: View {
    @EnvironmentObject private var pathStore: PathStore
    @State var timer: Timer?
    @State private var currentIndex = 0
    
    var userProblem: String
    
    var body: some View {
        
        PrimaryButton(text: " Continue ", isFull: true) {
            proceedToBreathing()
        }
        
        SecondaryButton(text: "Not now", isFull: true) {
            //
        }
        
    }
    func proceedToBreathing() {
        print("[proceedToBreathing][userProblem]", userProblem)
        pathStore.path.append(ViewPath.breathing(userProblem))
    }
}

struct ValidateFeelingView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateProblemView(userProblem: "")
    }
}
