//
//  SelfAffirmationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import SwiftUI

struct SelfAffirmationView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject var selfAffirmationVM = SelfAffirmationViewModel()
    
    @State private var didLongPress = false
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                //MARK: chat bubble
                if(!selfAffirmationVM.isFinished){
                    BubbleText(text: "Say '\(selfAffirmationVM.affirmationWords[selfAffirmationVM.currentAffirmationWordIndex])'", alignment: .vertical)
                } else {
                    
                        BubbleText(text: "Nicely done", alignment: .vertical)
                }
                //MARK: maskot image
                switch selfAffirmationVM.affirmationStage {
                case 0:
                    Image("brave-base")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .padding(16)
                case 1:
                    Image("brave-1")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .padding(16)
                case 2:
                    Image("brave-2")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .padding(16)
                default:
                    Image("brave-3")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .padding(16)
                    
                }
                
                
                if(!selfAffirmationVM.isFinished){
                    
                    if(selfAffirmationVM.isStarted){
                        Text("Your answer :  \(selfAffirmationVM.speechRecognizer.transcript)")
                    } else {
                        Text("Hold to start record and relase to stop")
                            .onAppear{
                                selfAffirmationVM.initStart()
                            }
                    }
                    //MARK: Button speech
                    Button {
                        if self.didLongPress {
                            self.didLongPress = false
                            selfAffirmationVM.offRecording()
                            selfAffirmationVM.toggleRecording()
                            //                        print(selfAffirmationVM.counterWord)
                        } else {
                            print("Tap button")
                        }
                    } label: {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 35)
                            .tint(.white)
                            .padding(16)
                    }
                    .frame(width: 80, height: 80)
                    .background(selfAffirmationVM.isRecording ? Color("SecondaryColor") : .black)
                    .cornerRadius(100)
                    .simultaneousGesture(
                        LongPressGesture().onEnded { _ in self.didLongPress = true
                            //Active Listening
                            selfAffirmationVM.onRecording()
                            selfAffirmationVM.toggleRecording()
                        }
                    )
                } else {
                    PrimaryButton(text: "Finish", isFull: true){
                        pathStore.popToRoot()
                    }
                }
                
                Spacer()
                //                //check answer
                //                if (selfAffirmationVM.isAnswer){
                //                    PrimaryButton(text: "Continue", isFull: true) {
                //                        proceedToHome()
                //                    }
                //                }
            }
            .padding()
            
        }
    }
    
    private func proceedToHome() {
        pathStore.popToRoot()
    }
}

struct SelfAffirmationView_Previews: PreviewProvider {
    static var previews: some View {
        SelfAffirmationView()
    }
}


//
//  SelfAffirmationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

//import SwiftUI
//
//struct SelfAffirmationView: View {
//    @StateObject var selfAffirmationVM = SelfAffirmationViewModel()
//
//    var body: some View {
//        VStack{
//            //TODO: Create view selfAffirmation
//            //MARK: chat bubble
//            BubbleText(text: "Say \(selfAffirmationVM.selectedWord.capitalized)")
//            //MARK: maskot image
//            Image("Mascot")
//                .padding(16)
//            //MARK: Button speech
//            ControlButton(systemName: selfAffirmationVM.isRecording ? "stop.fill" : "mic.fill") {
//                selfAffirmationVM.toggleRecording()
//            }
//
//            //check answer
//            if (selfAffirmationVM.isAnswer){
//                Text("You got it broh")
//                    .font(.title)
//            }
//        }
//        .onAppear{
//            selfAffirmationVM.getAffirmationWords()
//        }
//    }
//}
//
//struct SelfAffirmationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelfAffirmationView()
//    }
//}
