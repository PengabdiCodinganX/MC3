//
//  StoryView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import SwiftUI

struct StoryView: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var viewModel: StoryViewModel = StoryViewModel()
    @State private var scenes: [StageScene] = []
    
    var userProblem: String
    var story: StoryModel
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            if !scenes.isEmpty {
                SceneView(scenes: scenes) {
                    proceedToStoryRecap()
                }
            }
        }
        .onAppear {
            scenes = viewModel.getStageScenes(story: story)
        }
    }
    
    func proceedToStoryRecap() {
        pathStore.navigateToView(viewPath: .storyRecap(userProblem, story))
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(userProblem: "", story: StoryModel(keywords: [], introduction: [], problem: [], resolution: []))
    }
}
