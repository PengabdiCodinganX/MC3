//
//  ReflectionInputView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 25/07/23.
//

import SwiftUI

struct ReflectionInputView: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var viewModel: ReflectionInputViewModel = ReflectionInputViewModel()
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    
    @State private var textList: [TextTrack] = [TextTrack(text: "Now Reflect on the inspiring story and create an action plan for your next steps.", track: nil)]
    @State private var reflection: String = ""
    
    @State var history: HistoryModel
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Mascot(
                    mascotText: textList,
                    alignment: keyboardService.isKeyboardOpen
                    ? .horizontal
                    : .vertical,
                    mascotImage: keyboardService.isKeyboardOpen
                    ? .face
                    : .half,
                    mascotContentMode: .scaleAspectFit
                )
                .padding([.leading, .trailing])
                .onTapGesture {
                    hideKeyboard()
                }
                .background(Color("AccentColor"))
                
                VStack{
                    InputProblemView(userInput: $reflection, userInputType: .reflection, onSubmit: {
                        handleOnContinue()
                    })
                }
                .padding([.leading, .trailing, .bottom], 16)
                .padding(.top, 24)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .padding(.top, -16)
            }
        }
    }
    
    private func handleOnContinue() {
        Task {
            guard let history = await viewModel.updateHistory(history: history, reflection: reflection) else {
                return
            }
            
            self.history = history
            proceedToReflectionDetail()
        }
    }
    
    private func proceedToReflectionDetail() {
        pathStore.navigateToView(viewPath: .storyReflectionDetail(history))
    }
}

struct ReflectionInputView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionInputView(history: HistoryModel())
    }
}
