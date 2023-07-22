//
//  HomeView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject var pathStore: PathStore
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Mascot(text: "Good afternoon, dwq! What would you like to do?", alignment: .horizontal)
            
            MenuButton(
                text: "Share your story, Find relief!",
                menuButtonType: .big
            ) {
                
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    mainViewModel.signOut()
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
