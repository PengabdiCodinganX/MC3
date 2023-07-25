//
//  InputProblemView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct InputProblemView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject private var keyboardService: KeyboardService = KeyboardService()
 
    @State private var problem: String = ""
    
    var body: some View {
        ZStack {
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                //MARK: Mascot Chat
                Mascot(text: "If you have problem, you can share it with me.  I want you to know, there's no need to face it alone. I'm right here, ready and willing to lend an ear.", alignment: keyboardService.isKeyboardOpen ? .horizontal : .vertical, mascotImage: keyboardService.isKeyboardOpen ? .face : .half)
                    .padding()
                
                //MARK: TextEditor
                TextArea(placeholder: "Write down your problems here...", text: $problem)
                
                //MARK: Button
                PrimaryButton(text: "Continue", isFull: true) {
                    proceedToBreathing()
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
    
    func proceedToBreathing() {
        pathStore.navigateToView(viewPath: .story)
    }
}

struct InputProblemView_Previews: PreviewProvider {
    static var previews: some View {
        InputProblemView()
    }
}
