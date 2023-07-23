//
//  ContentView.swift
//  LionAnimation
//
//  Created by Muhammad Rezky on 15/07/23.
//

import SwiftUI

struct ContentView: View {
    var text = "aiueo halo aku singa"
    @State private var currentIndex = 0
    @State private var currentCharacter: Character = " "
    
    private var vowels: [Character] = ["a", "i", "u", "e", "o"]
    var body: some View {
         ZStack {
             Image("basic-body")
                 .resizable()
                 .scaledToFit()
             
             Image("a")
                 .resizable()
                 .scaledToFit()
                 .opacity(currentCharacter == "a" ? 1 : 0)
                 .animation(.easeIn(duration: 0.3))
             Image("i")
                 .resizable()
                 .scaledToFit()
                 .opacity(currentCharacter == "i" ? 1 : 0)
                 .animation(.easeIn(duration: 0.3))
             Image("u")
                 .resizable()
                 .scaledToFit()
                 .opacity(currentCharacter == "u" ? 1 : 0)
                 .animation(.easeIn(duration: 0.3))
             Image("e")
                 .resizable()
                 .scaledToFit()
                 .opacity(currentCharacter == "e" ? 1 : 0)
                 .animation(.easeIn(duration: 0.3))
             Image("o")
                 .resizable()
                 .scaledToFit()
                 .opacity(currentCharacter == "o" ? 1 : 0)
                 .animation(.easeIn(duration: 0.3))
             Image(String(randomImageName()))
                .resizable()
                .scaledToFit()
                .opacity(!vowels.contains(currentCharacter) ? 1 : 0)
         }
         .padding()
         .onAppear {
             startTimer()
         }
     }
     
     private func startTimer() {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
             if currentIndex < text.count {
                 currentCharacter = text[text.index(text.startIndex, offsetBy: currentIndex)]
                 currentIndex += 1
             } else {
                 currentIndex = 0
                 
             }
         }
     }
    
    private func randomImageName() -> String {
        let randomNumber = Int.random(in: 1...2)
        return "\(randomNumber)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
