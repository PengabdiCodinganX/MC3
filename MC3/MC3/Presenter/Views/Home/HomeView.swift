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
    
    @State private var text: String = ""
    
    @Binding var isSignedIn: Bool
    
    @State var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack {
//            Mascot(text: "Good afternoon, dwq! What would you like to do?", alignment: .horizontal)
//
//            MenuButton(
//                text: "Share your story, Find relief!",
//                menuButtonType: .big
//            ) {
//
//            }
//
//            HStack {
//                MenuButton(
//                    text: "Share your story, Find relief!",
//                    menuButtonType: .big
//                ) {
//
//                }
//
//                VStack {
//                    MenuButton(
//                        text: "Share your story, Find relief!",
//                        menuButtonType: .small
//                    ) {
//
//                    }
//
//                    MenuButton(
//                        text: "Share your story, Find relief!",
//                        menuButtonType: .small
//                    ) {
//
//                    }
//                }
//            }
            
            SingleTextField(placeholder: "Input text", text: $text)
            PrimaryButton(text: "Save") {
                Task {
                    try await viewModel.saveSound(text: text)
                }
            }
            
            if !viewModel.soundList.isEmpty {
                List(viewModel.soundList, id: \.self) { sound in
                    Button {
                        guard sound.sound != nil else {
                            print("[sound.sound]", sound.sound)
                            return
                        }
                        
                            playSound(data: sound.sound!)
                    } label: {
                        Text(sound.text ?? "")
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isSignedIn = false
                    } label: {
                        Image(systemName: "escape")
                    }
                    
                }
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Second") {
                    print("Pressed")
                }
            }
        }
    }
    
    func playSound(data: Data) {
        print("[playSound][data]", data)
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            print("[playSound][audioPlayer]", audioPlayer)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("[playSound][playing]")
        } catch {
            print("[playSound][error]", error)
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
