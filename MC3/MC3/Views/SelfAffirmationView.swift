//
//  SelfAffirmationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import SwiftUI

struct SelfAffirmationView: View {
    @StateObject var selfAffirmationVM = SelfAffirmationViewModel()
    
    var body: some View {
        VStack{
            //TODO: Create view selfAffirmation
            //MARK: chat bubble
            BubbleText(text: "Say \(selfAffirmationVM.selectedWord.capitalized)")
            //MARK: maskot image
            Image("Mascot")
                .padding(16)
            //MARK: Button speech
            ControlButton(systemName: selfAffirmationVM.isRecording ? "stop.fill" : "mic.fill") {
                selfAffirmationVM.toggleRecording()
            }
            
            //check answer
            if (selfAffirmationVM.isAnswer){
                Text("You got it broh")
                    .font(.title)
            }
        }
        .onAppear{
            selfAffirmationVM.getAffirmationWords()
        }
    }
}

struct SelfAffirmationView_Previews: PreviewProvider {
    static var previews: some View {
        SelfAffirmationView()
    }
}
