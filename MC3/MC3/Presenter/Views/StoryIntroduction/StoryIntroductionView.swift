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
    
    var userProblem: String
    
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
            
            if (story != nil) {
                //MARK: Continue Button
                PrimaryButton(text: "Continue", isFull: true) {
                    proceedToStory()
                }
                .padding(.horizontal, 16)
            } else {
                Text("Loading...")
            }
        }
        .task {
            do {
                self.story = try await viewModel.getStory(userProblem: self.userProblem)
            } catch {
                print("error", error)
            }
        }
    }
    
    func proceedToStory() {
        guard story != nil else {
            return
        }
        
        pathStore.path.append(ViewPath.story(userProblem, story!))
    }
}

struct IntroductionToStoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryIntroductionView(userProblem: "")
    }
}
