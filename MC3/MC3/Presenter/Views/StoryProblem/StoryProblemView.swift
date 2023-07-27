//
//  StoryIntroduction.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import SwiftUI

struct StoryProblemView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject private var viewModel: StoryProblemViewModel = StoryProblemViewModel()
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    
    @State private var history: HistoryModel?
    @State private var userProblem: String = ""
    @State private var storyProblemType: StoryProblemType = .inputProblem
    @State private var mascotText: [TextTrack] = []
    
    var body: some View {
        ZStack {
            Color("AccentColor").edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0){
                Mascot(mascotText: mascotText, alignment: keyboardService.isKeyboardOpen ? .horizontal : .vertical, mascotImage: keyboardService.isKeyboardOpen ? .face : .half, mascotContentMode: .scaleAspectFit)
                        .padding([.leading, .trailing])
                        .onTapGesture {
                            hideKeyboard()
                        }
                .background(Color("AccentColor"))
                VStack{
                    switch storyProblemType {
                    case .inputProblem:
                        InputProblemView(userInput: $userProblem, userInputType: .problem , onSubmit: {
                            handleOnClicked()
                        })
                    case .validateFeeling:
                        ValidateProblemView {
                            handleOnContinue()
                        } onDismiss: {
                            handleOnDismiss()
                        }

                    }
                }
                .padding([.leading, .trailing, .bottom], 16)
                .padding(.top, 24)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .padding(.top, -16)
            }
        }
        .onAppear { handleOnStoryProblemTypeChanges() }
        .onChange(of: storyProblemType) { _ in handleOnStoryProblemTypeChanges() }
    }
    
    func handleOnClicked() {
        guard !userProblem.isEmpty else {
            print("Error")
            return
        }
        
        let keyword = viewModel.getKeywordByText(text: userProblem)
        
        guard !keyword.isEmpty else {
            return
        }
        
        Task {
            history = try await viewModel.saveHistory(problem: userProblem)
            
            hideKeyboard()
            withAnimation(.spring()) {
                storyProblemType = .validateFeeling
            }
        }
    }
    
    func handleOnContinue() {
        proceedToBreathing()
    }
    
    func handleOnDismiss() {
        proceedToStory()
    }
    
    func handleOnStoryProblemTypeChanges() {
        switch storyProblemType {
        case .inputProblem:
            mascotText = problemData
        case .validateFeeling:
            mascotText = problemTwoData
        }
    }
    
        func proceedToBreathing() {
            guard history != nil else {
                print("history not found")
                return
            }
            
            pathStore.path.append(ViewPath.breathing(history!))
        }
    
    func proceedToStory() {
        guard history != nil else {
            return
        }
        
        pathStore.path.append(ViewPath.storyIntro(history!))
    }
}

struct StoryIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        StoryProblemView()
    }
}
