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
    
    @State private var isLoading: Bool = false
    @State private var reflection: String = ""
    @State var history: HistoryModel
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Mascot(
                    mascotText: reflectionData,
                    alignment: keyboardService.isKeyboardOpen
                    ? .horizontal
                    : .vertical,
                    mascotContentMode: .scaleAspectFit
                )
                .padding([.leading, .trailing])
                .onTapGesture {
                    hideKeyboard()
                }
                .background(Color("AccentColor"))
                
                VStack{
                    InputProblemView(userInput: $reflection, userInputType: .reflection, isLoading: isLoading, onSubmit: {
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
        isLoading = true
        
        Task {
            guard let history = await viewModel.updateHistory(history: history, reflection: reflection) else {
                isLoading = false
                return
            }
            
            isLoading = false
            
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
