//
//  StoryView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import SwiftUI

struct StoryView: View {
    @StateObject private var viewModel: StoryViewModel = StoryViewModel()
    @State private var scenes: [StageScene] = []
    
    var userProblem: String
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            switch viewModel.storyType {
            case .loading:
                LoadingView()
            case .scene:
                SceneView(scenes: scenes)
            }
    }
        .onAppear {
            Task {
                print("[userProblem]", userProblem)
                guard let story = try await viewModel.getStory(userProblem: userProblem) else {
                    return
                }
                
                scenes = viewModel.getStageScenes(story: story)
                viewModel.setScene()
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(userProblem: "Test")
    }
}
