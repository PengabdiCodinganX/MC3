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
    
    var history: HistoryModel
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
//        .navigationBarBackButtonHidden(true)
        .onAppear {
            scenes = viewModel.getStageScenes(story: story)
            
            let musicModel = MusicModel(musicType: .motivation)
            viewModel.playAudio(track: musicModel.track)
            viewModel.setVolume(0.5)
        }
        .onDisappear {
            viewModel.stopAudio()
        }
    }
    
    func proceedToStoryRecap() {
        pathStore.navigateToView(viewPath: .storyRecap(history, story))
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(history: HistoryModel(), story: StoryModel(keywords: [], introduction: [], problem: [], resolution: []))
    }
}
