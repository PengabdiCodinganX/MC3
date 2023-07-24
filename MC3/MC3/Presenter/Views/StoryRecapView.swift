//
//  StoryRecapView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct StoryRecapView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @State private var rating: Int = 0
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                //MARK: Title and sound
                header()
                
                //MARK: Rate the story star
                VStack(alignment: .leading){
                    Text("Rate the story")
                        .font(.title2)
                    
                    RatingButton(rating: $rating)
                }
                .padding(.vertical)
                
                //MARK: Scroll Story View
                ScrollView(showsIndicators: false){
                    ForEach(storyData , id: \.self) { story in
                        Text(story)
                            .lineSpacing(5)
                            .padding()
                            .background(.white)
                            .cornerRadius(12)
                            .padding(.bottom, 16)
                    }
                }
                
                Button {
                    proceedToStoryRepeat()
                } label: {
                    Text("temporary next nanti ganti")
                }

            }
            .padding()
        }
    }
    
    func header() -> some View{
        return HStack{
            Text("Recap Story")
                .font(.title)
                .fontWeight(.semibold)
            Spacer()
            
            Button {
                print("")
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
    
    func proceedToStoryRepeat() {
        pathStore.navigateToView(viewPath: .story)
    }
}



struct StoryRecapView_Previews: PreviewProvider {
    static var previews: some View {
        StoryRecapView()
    }
}
