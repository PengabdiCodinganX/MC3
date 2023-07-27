//
//  StoryRecapView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct StoryRecapView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject private var viewModel: StoryRecapViewModel = StoryRecapViewModel()
    
    @State private var rating: RatingModel?
    @State private var rate: Int = 0
    @State private var storyData: [String]?
    @State private var storyAudio: [Data]?
    @State private var storyAudioIndex: Int = 0
    
    @State var history: HistoryModel
    var story: StoryModel
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                //MARK: Title and sound
                header()
                
                //MARK: Rate the story star
                VStack(alignment: .leading) {
                    Text("Rate the story")
                        .font(.title2)
                    
                    RatingButton(rating: $rate)
                }
                .padding(.vertical)
                
                if storyData != nil && !storyData!.isEmpty {
                    //MARK: Scroll Story View
                    ScrollView(showsIndicators: false){
                        ForEach(storyData! , id: \.self) { story in
                            Text(story)
                                .lineSpacing(5)
                                .padding()
                                .background(.white)
                                .cornerRadius(12)
                                .padding(.bottom, 16)
                        }
                    }
                }
                
                PrimaryButton(text: "Continue", isFull: true) {
                    handleOnContinue()
                }
                
            }
            .padding()
        }
        .onAppear {
            self.storyData = viewModel.getStoryData(story: story)
            self.storyAudio = viewModel.getStoryAudio(story: story)
        }
        .onChange(of: viewModel.isPlaying) { isPlaying in
            print("[viewModel.isPlaying]", isPlaying)
            guard !isPlaying else {
                return
            }
            
            playNextAudio()
        }
    }
    
    func header() -> some View{
        return HStack{
            Text("Recap Story")
                .font(.title)
                .fontWeight(.semibold)
            Spacer()
            
            Button {
                storyAudioIndex = 0
                playAudio()
            } label: {
                Image(systemName: "speaker.wave.2.bubble.left.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
            }
            .padding()
            .background()
            .cornerRadius(12)
        }
    }
    
    func handleOnContinue() {
        Task {
            guard let rating = try await viewModel.saveRating(rate: rate, story: story) else {
                return
            }
            
            guard let history = await viewModel.updateHistory(history: history, rating: rating) else {
                return
            }
            
            self.history = history
            
            proceedToStoryReflection()
        }
    }
    
    func playNextAudio() {
        storyAudioIndex += 1
        playAudio()
    }
    
    func playStoryAudio() {
        storyAudioIndex = 0
        playAudio()
    }
    
    func playAudio() {
        guard let storyAudio = storyAudio else {
            return
        }
        
        guard storyAudioIndex < storyAudio.count - 1 else {
            return
        }
        
        viewModel.playAudio(sound: storyAudio[storyAudioIndex])
    }
    
    func proceedToStoryReflection() {
        pathStore.path.append(ViewPath.storyReflection(history))
    }
}



struct StoryRecapView_Previews: PreviewProvider {
    static var previews: some View {
        StoryRecapView(history: HistoryModel(), story: StoryModel(keywords: ["test"], introduction: ["test"], problem: ["test"], resolution: ["test"]))
    }
}
