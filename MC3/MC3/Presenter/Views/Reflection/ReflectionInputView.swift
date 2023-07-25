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
    
    @State private var feedback: String = ""
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                //MARK: Mascot Chat
                Mascot(textList: Constant().reflectionData, alignment: keyboardService.isKeyboardOpen ? .horizontal : .vertical, mascotImage: keyboardService.isKeyboardOpen ? .face : .half)
                    .padding()
                
                VStack{
                    //MARK: TextEditor
                    TextArea(placeholder: "Write down your reflection here", text: $feedback)
                        
                    
                    //MARK: Button
                    PrimaryButton(text: "Next", isFull: true) {
                        print()
                    }
                    .padding(.horizontal)
                }
                .background(.white)
            }
        }
    }
}

struct ReflectionInputView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionInputView()
    }
}
