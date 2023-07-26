//
//  InputProblemView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct InputProblemView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject private var viewModel: InputProblemViewModel = InputProblemViewModel()
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    
    @Binding var userProblem: String
    @State private var textList: [TextTrack] = problemData
    
    @Binding var storyProblemType: StoryProblemType
    
    var body: some View {
        
            TextArea(placeholder: "Write down your problems here...", text: $userProblem)
                .padding(.bottom, 16)
            //MARK: Button
            PrimaryButton(text: "Continue", isFull: true) {
                handleOnClicked()
            }

        
    }
    
    func handleOnClicked() {
        guard !userProblem.isEmpty else {
            print("Error")
            return
        }
        
        withAnimation(.spring()) {
            storyProblemType = .validateFeeling
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct InputProblemView_Previews: PreviewProvider {
    static var previews: some View {
        InputProblemView(userProblem: .constant("test"), storyProblemType: .constant(.inputProblem))
    }
}
