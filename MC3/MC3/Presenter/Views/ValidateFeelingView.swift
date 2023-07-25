//
//  StoryIntroductionView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct ValidateFeelingView: View {
    @EnvironmentObject private var pathStore: PathStore
    @State var timer: Timer?
    @State private var currentIndex = 0
    @State private var texts: [String] = [].reversed()
    
    
    private func setupTimer() {
        withAnimation{
            
                texts.append(introduceData[currentIndex])
        }
        currentIndex += 1
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            withAnimation{
                texts.append(introduceData[currentIndex])
                currentIndex += 1
            }
            if(currentIndex == introduceData.count){
                timer?.invalidate() 
            }
        }
    }
    var body: some View {
        ZStack {
            Color("AccentColor").edgesIgnoringSafeArea(.all)
                .onAppear{
                    setupTimer()
                }
            VStack(spacing: 0){
                Spacer()
                VStack{
                    ForEach(texts.indices, id: \.self){index in
                        BubbleText(text: texts[index], alignment: .vertical, showPointer: index == texts.count-1, textAlignment: .leading)
                            .opacity(index == texts.count-1 ? 1 : 0.5)
                            .padding(.bottom, 8)
                          
                    }
                    LottieView(lottieFile: "charachter-animation-lottie", loopMode: .loop, contentMode: .scaleAspectFill)
                        .frame(height: 270)
                }
                .padding([.leading, .top, .trailing], 32)
                HStack{
                    Button(action: {}){
                        Text("Not now")
                            .underline().foregroundColor(.black)
                    }
                    Spacer()
                    PrimaryButton(text: " Continue ") {
                        proceedToStoryRecap()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .background(.white)
            }
        }
    }
    
    func proceedToStoryRecap() {
        pathStore.navigateToView(viewPath: .storyRecap)
    }
}

struct ValidateFeelingView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateFeelingView()
    }
}
