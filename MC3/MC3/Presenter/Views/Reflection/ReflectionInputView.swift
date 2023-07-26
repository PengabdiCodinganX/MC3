//
//  ReflectionInputView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 25/07/23.
//

import SwiftUI

struct ReflectionInputView: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    @State private var textList: [TextTrack] = [TextTrack(text: "Now Reflect on the inspiring story and create an action plan for your next steps.", track: nil)]
    @State private var feedback: String = ""
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0){
                Mascot(textList: textList, alignment: keyboardService.isKeyboardOpen ? .horizontal : .vertical, mascotImage: keyboardService.isKeyboardOpen ? .face : .half, mascotContentMode: .scaleAspectFit)
                    .padding([.leading, .trailing])
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .background(Color("AccentColor"))
                
                VStack{
                    InputProblemView(userInput: $feedback, userInputType: .reflection, onSubmit: {
                        pathStore.path.append(ViewPath.storyReflection)
                    })
                    
                }
                .padding([.leading, .trailing, .bottom], 16)
                .padding(.top, 24)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .padding(.top, -16)
            }
        }
    }
}

struct ReflectionInputView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionInputView()
    }
}
