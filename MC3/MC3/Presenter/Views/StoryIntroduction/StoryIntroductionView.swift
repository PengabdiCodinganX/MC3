//
//  IntroductionToStroyView.swift
//  MC3
//
//  Created by Muhammad Rezky on 24/07/23.
//

import SwiftUI

struct StoryIntroductionView: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var viewModel: StoryIntroductionViewModel = StoryIntroductionViewModel()
    
    @State private var story: StoryModel?
    @State var history: HistoryModel
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                LottieView(lottieFile: "introduction-story-lottie", loopMode: .loop, contentMode: .scaleAspectFit)
                    .ignoresSafeArea()
                    .padding(.top, -200)
                BubbleText(text: "Now I'd want to tell you a story. I believe that this narrative will benefit you in some way. Pay close attention, listen, and see if you can relate.", alignment: .vertical)
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                
            }
            Spacer()
            
            if isLoading {
                Text("Loading...")
            } else {
                //MARK: Continue Button
                PrimaryButton(text: "Continue", isFull: true) {
                    proceedToStory()
                }
                .padding(.horizontal, 16)
            }
        }
        .task {
            do {
                self.isLoading = true
                
                guard let problem = history.problem else {
                    self.isLoading = false
                    return
                }
                
                guard let story = try await viewModel.getStory(userProblem: problem) else {
                    self.isLoading = false
                print("[story not found]")
                    return
                }
                
                self.story = story
                
                guard let history = try await viewModel.updateHistory(history: self.history, story: story) else {
                    self.isLoading = false
                    return
                }
                
                self.history = history
                self.isLoading = false
            } catch {
                print("error", error)
            }
        }
    }
    
    func proceedToStory() {
        guard story != nil else {
            return
        }
        
        pathStore.path.append(ViewPath.story(history, story!))
    }
}

struct IntroductionToStoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryIntroductionView(history: HistoryModel())
    }
}
