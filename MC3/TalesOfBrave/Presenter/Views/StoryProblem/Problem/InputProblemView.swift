//
//  InputProblemView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct InputProblemView: View {
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    @Binding var userInput: String
    var userInputType: UserInputType
    
    var isLoading: Bool
    let onSubmit: () -> Void
    
    var body: some View {
        TextArea(placeholder: "Write down your \(userInputType.rawValue) here...", text: $userInput)
            .padding(.bottom, 16)
        //MARK: Button
        PrimaryButton(text: "Continue", isFull: true, isLoading: isLoading) {
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
        InputProblemView(userInput: .constant("aaa"), userInputType: .problem, isLoading: false, onSubmit: {})
    }
}
