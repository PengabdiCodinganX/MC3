//
//  HomeView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    @EnvironmentObject private var pathStore: PathStore
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var text: String = ""
    @State var audioPlayer: AVAudioPlayer?
    
    @Binding var isSignedIn: Bool
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                Mascot(textList: [TextTrack(text: "Good afternoon, \(viewModel.user.name ?? "")! What would you like to do?", track: "")], alignment: .horizontal)
                
                MenuButton(
                    text: "Share your story, Find relief!",
                    menuButtonType: .big
                ) {
                    proceedToProblem()
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
        .navigationDestination(for: ViewPath.self) { viewPath in
            withAnimation() {
                viewPath.view
            }.transition(.opacity)
        }
    }
    
    func proceedToProblem() {
        pathStore.navigateToView(viewPath: .problem)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isSignedIn: .constant(false))
    }
}
