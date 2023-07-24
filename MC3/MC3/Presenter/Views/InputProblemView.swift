//
//  InputProblemView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct InputProblemView: View {
    @State private var problem: String = ""
    @State private var isTyping: Bool = false
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                //MARK: Mascot Chat
                Mascot(text: "If you have problem, you can share it with me.  I want you to know, there's no need to face it alone. I'm right here, ready and willing to lend an ear.", alignment: isTyping ? .horizontal : .vertical,mascotImage: isTyping ? .face : .half)
                    .padding()
                
                //MARK: TextEditor
                TextEditor(text: $problem)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .lineSpacing(5)
                    .padding()
                    .onTapGesture {
                        // Check typing
                        withAnimation{
                            isTyping.toggle()
                        }
                        
                        // Dismiss the keyboard and remove focus from the TextEditor
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                
                //MARK: Button
                PrimaryButton(text: "Continue", isFull: true) {
                    print()
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .onTapGesture {
            // Check typing
            withAnimation{
                isTyping = false
            }
            // Dismiss the keyboard and remove focus from the TextEditor when tapping on the ZStack
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct InputProblemView_Previews: PreviewProvider {
    static var previews: some View {
        InputProblemView()
    }
}
