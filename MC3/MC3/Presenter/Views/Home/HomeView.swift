//
//  HomeView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @EnvironmentObject var pathStore: PathStore
    
    @State private var data: Data?
    @State private var audioPlayer: AVAudioPlayer?
    
    @Binding var isSignedIn: Bool
        
    
    
    var body: some View {
        VStack {
            Mascot(text: "Good afternoon, dwq! What would you like to do?", alignment: .horizontal)
            
            MenuButton(
                text: "Share your story, Find relief!",
                menuButtonType: .big
            ) {
                print("pressed")
                
                do {
                    
                    guard audioPlayer != nil else {
                        print("audioPlayer empty")
                        return
                    }
                    
                    // Ensure the player is prepared to play
                    self.audioPlayer!.prepareToPlay()
                    
                    // Start playing
                    self.audioPlayer!.play()
                    print("pressed play")
                } catch {
                    print("Error playing MP3: \(error)")
                }
            }
            
            HStack {
                MenuButton(
                    text: "Share your story, Find relief!",
                    menuButtonType: .big
                ) {
                    
                }
                
                VStack {
                    MenuButton(
                        text: "Share your story, Find relief!",
                        menuButtonType: .small
                    ) {
                        
                    }
                    
                    MenuButton(
                        text: "Share your story, Find relief!",
                        menuButtonType: .small
                    ) {
                        
                    }
                }
            }
        }
        .padding()
        .task {
            do {
                data = try await ElevenLabsAPIService().fetchTextToSpeech(text: "hey everyone my name", voiceId: "21m00Tcm4TlvDq8ikWAM")
                
                guard data != nil else {
                    print("data empty")
                    return
                }
                
                audioPlayer = try AVAudioPlayer(data: data!)
            } catch {
                print("Test", error)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isSignedIn = false
                } label: {
                    Image(systemName: "escape")
                }
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Second") {
                    print("Pressed")
                }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
