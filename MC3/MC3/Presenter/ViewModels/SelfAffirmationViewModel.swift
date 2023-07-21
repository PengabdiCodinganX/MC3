//
//  SelfAffirmationViewModel.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import Foundation
import SwiftUI

class SelfAffirmationViewModel: ObservableObject{
    //variable
    @Published var selectedWord: String = ""
    @Published var isRecording: Bool = false
    @Published var isAnswer: Bool = false
    
    var speechRecognizer = SpeechRecognizer()
    var affirmationWords: [String] = ["i can do it", "i can do more", "i can be better"]
    var counterWord: Int = 0
    
    
    func getAffirmationWords(){
        //TODO: Create bank file of affirmation words
        if(selectedWord == ""){
            selectedWord = affirmationWords[self.counterWord]
        }else{
            if(isAnswer && counterWord < 2){
                self.counterWord += 1
                withAnimation{
                    selectedWord = affirmationWords[self.counterWord]
                }
                isAnswer = false
            }
        }
    }
    
    // Function to toggle recording state and call speech recognizer methods
    func toggleRecording() {
        if !isRecording {
            speechRecognizer.transcribe()
        } else {
            speechRecognizer.stopTranscribing()
            checkAnswer()
            getAffirmationWords()
        }
        isRecording.toggle()
    }
    
    // Function to compare answer and transcribe
    func checkAnswer(){
        print(speechRecognizer.transcript)
        if(isRecording == true && speechRecognizer.transcript != ""){
            isAnswer = speechRecognizer.transcript.lowercased() == selectedWord.lowercased()
        }
    }
}
