//
//  TextToSpeechExampleView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 13/07/23.
//

import SwiftUI
import AVKit

struct TextToSpeechExampleView: View {
    @State private var inputString = """
    “Do you know how hunters of old used to trap monkeys?” A man asked his child.

    “Rather than chasing them up a tree or shooting arrows from below, they’d put a heavy glass jar with a narrow neck on the floor, which had the monkeys’ favourite food inside.

    They’d then step back and hide, waiting for the unsuspecting animal to approach.
"""
    
    let synthesizer = AVSpeechSynthesizer()
    let voice = TextToSpeech()
    
    var body: some View {
        VStack{
            TextField("Enter text", text: $inputString)
                .textFieldStyle(.roundedBorder)
                .padding()
//            Text("Pitch \(pitch)")
//            Slider(value: $pitch, in: 0.5...2)
//            Text("Volume")
//            Slider(value: $volume, in: 0...1)
            
            
            Button("Text to speech") {
//                print(AVSpeechSynthesisVoice.speechVoices())
                // add utterance here
//                let utterance = AVSpeechUtterance(string: inputString)
//                utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
////                utterance.rate = 0.3
//                utterance.pitchMultiplier = 2.0
////                utterance.rate = 0.8
//                self.synthesizer.speak(utterance)
                voice.sayThis(inputString)
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct TextToSpeechExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextToSpeechExampleView()
    }
}
