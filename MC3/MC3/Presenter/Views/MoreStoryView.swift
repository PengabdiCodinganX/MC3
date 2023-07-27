//
//  MoreStoryView.swift
//  MC3
//
//  Created by Muhammad Rezky on 25/07/23.
//

import SwiftUI

struct MoreStoryView: View {
    @StateObject var animationController = LottieController()

    var body: some View {
        VStack{
            ZStack(alignment: .top){
                
                LottieView(controller: animationController, lottieFile: "introduction-story-lottie", loopMode: .loop, contentMode: .scaleAspectFit)
                    .ignoresSafeArea()
                    .padding(.top, -200)
                BubbleText(text: "You've come far, from stress to motivation and plans. Believe in yourself. Let's do self-affirmation—it boosts confidence!", alignment: .vertical)
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                
            }
            Spacer()
            
            //MARK: Continue Button
            SecondaryButton(text: "Get Another Story", isFull: true) {
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            //MARK: Continue Button
            PrimaryButton(text: "Continue", isFull: true) {
            }
            .padding(.horizontal, 16)

        }
    }
}

struct MoreStoryView_Previews: PreviewProvider {
    static var previews: some View {
        MoreStoryView()
    }
}
