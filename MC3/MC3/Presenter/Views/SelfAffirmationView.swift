//
//  SelfAffirmationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import SwiftUI

struct SelfAffirmationView: View {
    @StateObject var selfAffirmationVM = SelfAffirmationViewModel()
    @State private var didLongPress = false
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                //MARK: chat bubble
                BubbleText(text: "Say \(selfAffirmationVM.selectedWord.capitalized)", alignment: .vertical)
                //MARK: maskot image
                Image("Mascot-Half-Body")
                    .padding(16)
                //MARK: Button speech
                Button {
                    if self.didLongPress {
                        self.didLongPress = false
                        selfAffirmationVM.ofRecording()
                        selfAffirmationVM.toggleRecording()
                        print(selfAffirmationVM.counterWord)
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
                
                Spacer()
                //check answer
                if (selfAffirmationVM.isAnswer){
                    PrimaryButton(text: "Continue", isFull: true) {
                        //TODO: Navigate path
                        print()
                    }
                }
            }
            .padding()
            .onAppear{
                selfAffirmationVM.getAffirmationWords()
            }
        }
    }
}

struct SelfAffirmationView_Previews: PreviewProvider {
    static var previews: some View {
        SelfAffirmationView()
    }
}
