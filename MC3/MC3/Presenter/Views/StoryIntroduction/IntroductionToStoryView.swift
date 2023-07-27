////
////  IntroductionToStroyView.swift
////  MC3
////
////  Created by Muhammad Rezky on 24/07/23.
////
//
//import SwiftUI
//
//struct IntroductionToStoryView: View {
//    @EnvironmentObject private var pathStore: PathStore
//    
//    var userProblem: String
//    @StateObject var animationController = LottieController()
//    @StateObject var mouthAnimationController = LottieController()
//    var body: some View {
//        VStack{
//            ZStack(alignment: .top){
//                
//                ZStack{
//                    LottieView(controller: animationController, lottieFile: "introduction-story-lottie", loopMode: .loop, contentMode: .scaleAspectFit)
//                        .ignoresSafeArea()
//                        .padding(.top, -200)
//                    LottieView(controller: mouthAnimationController, lottieFile: "introduction-story-mouth-lottie", loopMode: .autoReverse, contentMode: .scaleAspectFit)
//                        .ignoresSafeArea()
//                        .padding(.top, -200)
//                }
//                BubbleText(text: "Now I'd want to tell you a story. I believe that this narrative will benefit you in some way. Pay close attention, listen, and see if you can relate.", alignment: .vertical)
//                    .padding(.horizontal, 24)
//                    .padding(.top, 32)
//                
//            }
//            Spacer()
//            
//            //MARK: Continue Button
//            PrimaryButton(text: "Continue", isFull: true) {
//                proceedToStory()
//            }
//            .padding(.horizontal, 16)
//        }
//    }
//    
//    func proceedToStory() {
//        pathStore.path.append(ViewPath.story(sto))
//    }
//}
//
//struct IntroductionToStoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        IntroductionToStoryView(userProblem: "")
//    }
//}
