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
 
    @State private var problem: String = ""
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0){
                Mascot(textList: Constant().problemData, alignment: keyboardService.isKeyboardOpen ? .horizontal : .vertical, mascotImage: keyboardService.isKeyboardOpen ? .face : .half)
                    .padding([.leading, .top, .trailing])
                    .onTapGesture {
                        hideKeyboard()
                }
                .background(Color("AccentColor"))
                
                //MARK: TextEditor
                Rectangle()
                    .frame(height: 16)
                    .foregroundColor(Color("AccentColor"))
                
                VStack{
                    TextArea(placeholder: "Write down your problems here...", text: $problem)
                        .padding(.bottom, 16)
                    //MARK: Button
                    PrimaryButton(text: "Continue", isFull: true) {
                        proceedToBreathing()
                    }
                }
                .padding([.leading, .trailing, .bottom], 16)
                .padding(.top, 24)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .padding(.top, -16)
            }
        }
    }
    
    func handleOnClicked() {
        guard !problem.isEmpty else {
            print("Error")
            return
        }
    }
    
    func proceedToBreathing() {
        pathStore.navigateToView(viewPath: .story)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct InputProblemView_Previews: PreviewProvider {
    static var previews: some View {
        InputProblemView()
    }
}
