//
//  StoryIntroduction.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import SwiftUI



struct StoryProblemView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject private var viewModel: StoryIntroductionViewModel = StoryIntroductionViewModel()
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    
    @State private var userProblem: String = ""
    @State private var storyProblemType: StoryProblemType = .inputProblem
    @State private var textList: [TextTrack] = []
    
    
    
    var body: some View {
        ZStack {
            Color("AccentColor").edgesIgnoringSafeArea(.top)
            VStack(spacing: 0){
                Mascot(textList: textList, alignment: keyboardService.isKeyboardOpen ? .horizontal : .vertical, mascotImage: keyboardService.isKeyboardOpen ? .face : .half, mascotContentMode: .scaleAspectFit)
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
                        ValidateProblemView(userProblem: userProblem)
                    }
                }
                .padding([.leading, .trailing, .bottom], 16)
                .padding(.top, 24)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .padding(.top, -16)
            }
        }
        .onAppear { 
            handleOnStoryProblemTypeChanges()
        }
        .onChange(of: storyProblemType) { storyProblemType in
            handleOnStoryProblemTypeChanges()
        }
        .navigationBarItems(leading: customBackButton)
        .navigationBarBackButtonHidden(true)
    }
    
    
    func handleOnClicked() {
        guard !userProblem.isEmpty else {
            print("Error")
            return
        }
        hideKeyboard()
        withAnimation(.spring()) {
            storyProblemType = .validateFeeling
        }
    }
    
    func handleOnStoryProblemTypeChanges() {
        switch storyProblemType {
        case .inputProblem:
            textList = problemData
        case .validateFeeling:
            textList = problemTwoData
        }
    }
    
    var customBackButton: some View {
        Button(action: {
            switch storyProblemType {
            case .inputProblem:
                pathStore.popToRoot()
            case .validateFeeling:
                storyProblemType = .inputProblem
            }
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        }
    }
}

struct StoryIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        StoryProblemView()
    }
}
