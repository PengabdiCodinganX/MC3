//
//  HomeView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: OnboardingViewModel = OnboardingViewModel()
    @EnvironmentObject var pathStore: PathStore
    
    var body: some View {
        VStack {
            Mascot(text: "Good afternoon, \(viewModel.name)! What would you like to do?", alignment: .horizontal)
            
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
            
            VS
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
