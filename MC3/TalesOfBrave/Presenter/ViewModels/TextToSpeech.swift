//
//  TextToSpeech.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 15/07/23.
//

import Foundation
import AVFoundation

class TextToSpeech {

    let voices = AVSpeechSynthesisVoice.speechVoices()
    let voiceSynth = AVSpeechSynthesizer()
    var voiceToUse: AVSpeechSynthesisVoice?

  init(){
    for voice in voices {
        print("name \(voice.name) -> lang \(voice.language)")
      if voice.name == "Samantha (Enhanced)"  && voice.quality == .enhanced {
        voiceToUse = voice
      }else{
          if voice.name == "Samantha"{
              voiceToUse = voice
          }
      }
    }
  }

    func sayThis(_ phrase: String){
      let utterance = AVSpeechUtterance(string: phrase)
          utterance.voice = voiceToUse
        utterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.5

        voiceSynth.speak(utterance)
    }
}
