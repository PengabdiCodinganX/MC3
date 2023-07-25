//
//  IntroductionToStroyView.swift
//  MC3
//
//  Created by Muhammad Rezky on 24/07/23.
//

import SwiftUI

struct IntroductionToStoryView: View {
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                
                LottieView(lottieFile: "introduction-story-lottie", loopMode: .loop, contentMode: .scaleAspectFit)
                    .ignoresSafeArea()
                    .padding(.top, -200)
                BubbleText(text: "Now I'd want to tell you a story. I believe that this narrative will benefit you in some way. Pay close attention, listen, and see if you can relate.", alignment: .vertical)
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                
            }
            Spacer()
            
            //MARK: Continue Button
            PrimaryButton(text: "Continue", isFull: true) {
            }
            .padding(.horizontal, 16)
        }
    }
}

struct IntroductionToStoryView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionToStoryView()
    }
}
