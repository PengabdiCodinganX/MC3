//
//  WorryView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 13/07/23.
//

import SwiftUI

struct WorryView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    var body: some View {
        Text(speechRecognizer.transcript)
            .padding()
        
        Button(action: {
            if !isRecording {
                speechRecognizer.transcribe()
            } else {
                speechRecognizer.stopTranscribing()
            }
            
            isRecording.toggle()
        }, label: {
            Text(isRecording ? "Stop" : "Record")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(isRecording ? .red : .blue)
                .cornerRadius(20)
        })
        //TODO: Circle with button
        //TODO: Convert live speech to text
    }
}

struct WorryView_Previews: PreviewProvider {
    static var previews: some View {
        WorryView()
    }
}
