//
//  ReflectionCompleteView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 25/07/23.
//

import SwiftUI

struct ReflectionCompleteView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
    
    @State private var textList: [TextTrack] = reflectionTwoData
    @State private var feedback: String = ""
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0){
                Mascot(mascotText: reflectionTwoData, alignment: keyboardService.isKeyboardOpen ? .horizontal : .vertical, mascotContentMode: .scaleAspectFit)
                    .padding([.leading, .trailing])
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .background(Color("AccentColor"))
                
                VStack(spacing: 20){
                    PrimaryButton(text: " Let’s do it! ", isFull: true) {
                        proceedToSelfAffirmation()
                    }
                    
                    SecondaryButton(text: "Maybe next time...", isFull: true) {
                        proceedToHome()
                    }
                    
                }
                .padding([.leading, .trailing, .bottom], 16)
                .padding(.top, 24)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .padding(.top, -16)
            }
        }
    }
    
    private func proceedToSelfAffirmation() {
        pathStore.navigateToView(viewPath: .selfAffirmation)
    }
    
    private func proceedToHome() {
        pathStore.popToRoot()
    }
}

struct ReflectionCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionCompleteView()
    }
}
