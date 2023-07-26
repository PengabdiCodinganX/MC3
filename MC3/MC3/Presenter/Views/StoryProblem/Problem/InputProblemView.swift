//
//  InputProblemView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct InputProblemView: View {
//    @EnvironmentObject private var pathStore: PathStore
//    @StateObject private var viewModel: InputProblemViewModel = InputProblemViewModel()
    //    @State private var textList: [TextTrack] = problemData
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    @Binding var userInput: String
   var userInputType: UserInputType
    var onSubmit: () -> Void
    
    var body: some View {
        
        TextArea(placeholder: "Write down your \(userInputType.rawValue) here...", text: $userInput)
                .padding(.bottom, 16)
            //MARK: Button
            PrimaryButton(text: "Continue", isFull: true) {
                onSubmit()
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
        InputProblemView(userInput: .constant("aaa"), userInputType: .problem, onSubmit: {})
    }
}
