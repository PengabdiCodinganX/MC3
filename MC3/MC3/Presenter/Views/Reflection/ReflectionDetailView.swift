//
//  ReflectionDetailView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 25/07/23.
//

import SwiftUI

struct ReflectionDetailView: View {
    @State private var reflection: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nisi scelerisque eu ultrices vitae auctor eu augue ut lectus. Sit amet volutpat consequat mauris. Lectus nulla at volutpat diam ut venenatis tellus in. Id leo in vitae turpis massa sed elementum. Sapien pellentesque habitant morbi tristique senectus et netus."
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack(){
                Text("Go Over Your Reflection")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(reflection)
                    .lineSpacing(5)
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                Spacer()
                
                PrimaryButton(text: "Continue", isFull: true) {
                    print()
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct ReflectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionDetailView()
    }
}
