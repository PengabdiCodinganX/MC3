//
//  HomeView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI
import AVFoundation

enum HomeState{
    case base
    case loading
    case motivate
}

struct HomeView: View {
    @State var state: HomeState = .base
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @State private var user: UserModel?
    @Binding var isSignedIn: Bool
    
    @State var textTrack: [TextTrack] = [dashboardData[0]]
    
    func handleMascotTap(){
        switch state{
        case .base:
            processToMotivation()
        case .loading:
            print("loading")
        case .motivate:
            processToBase()
        }
    }
    func processToBase(){
        state = .base
        initTrack()
    }
    func processToMotivation(){
        state = .loading
        initTrack()
    }
    
    func getMotivationTrack() -> TextTrack{
        return motivationData.randomElement()!
    }
    
    func initTrack(){
        switch state{
        case .base:
            textTrack = [dashboardData[0]]
        case .loading:
            textTrack = [dashboardData[1]]
        case .motivate:
            textTrack = [getMotivationTrack()]
        }
        
        mouthLottieController.play()
    }
    
    
    @StateObject var mouthLottieController = LottieController()
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.top)
            VStack(spacing: 0){
                Mascot(mascotText: textTrack, alignment: .vertical, mascotImage: .show, mascotContentMode: .scaleAspectFit,mouthLottieController: mouthLottieController,onCompletePlaying: {
                    if(state == .loading){
                        state = .motivate
                        initTrack()
                    }
                })
                    .padding([.horizontal, .top], 32)
                    .onTapGesture {
                        handleMascotTap()
                    }
                VStack(spacing: 16){
                    Button{
                        pathStore.navigateToView(viewPath: .problem)
                    } label: {
                        HStack{
                            ZStack{
                                Rectangle()
                                    .frame(width: 56, height: 56)
                                    .foregroundColor(Color("SecondaryColorDark"))
                                    .cornerRadius(10)
                                    .padding(12)
                                Image(systemName: "mic.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 24)
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 4){
                                Text("Share your story")
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                Text("Relief stress by sharing your story")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                            }
                            .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(12)
                        .background(Color("SecondaryColor"))
                        .cornerRadius(16)
                    }
                    Button{} label: {
                        HStack{
                            ZStack{
                                Rectangle()
                                    .frame(width: 56, height: 56)
                                    .foregroundColor(Color("SecondaryColorDark"))
                                    .cornerRadius(10)
                                    .padding(12)
                                Image(systemName: "book.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 24)
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 4){
                                Text("Your Reflection")
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                Text("Maybe your past experience help")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                            }
                            .foregroundColor(Color("SecondaryColorDark"))
                            Spacer()
                        }
                        .padding(12)
                        .background(Color("AccentColor"))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 36)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
            }
            
        }
        .task {
            user = await viewModel.getUser()
            print("[user]", user)
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
