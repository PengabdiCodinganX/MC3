//
//  MeditationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import SwiftUI

enum BreatheStatus: String{
    case breatheIn = "breathe-in-mouth"
    case breatheOut = "breathe-out-mouth"
    case hold = "breathe-hold-mouth"
    
    var textBreath: String{
        switch self{
        case .breatheIn:
            return "Breathe in..."
        case .hold:
            return "Hold..."
        case .breatheOut:
            return "Breathe out..."
        }
    }
}

struct BreathingView: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject var meditationVM: BreathingViewModel = BreathingViewModel()
    @State private var breathText: String = "Breathe in..."
    
    @State var status: BreatheStatus = BreatheStatus.breatheIn
    @State var timer: Timer?
    
    var history: HistoryModel
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            withAnimation{
                switch status {
                case .breatheIn:
                    status = .hold
                case .breatheOut:
                    status = .breatheIn
                case .hold:
                    status = .breatheOut
                }
                
                breathText = status.textBreath
            }
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    var body: some View {
        VStack(spacing: 0){
            //MARK: Animation & Bubble Stack
            ZStack(alignment: .top){
                //MARK: Animation
                LottieView(
                    lottieFile: "breathing-lottie",
                    loopMode: .loop,
                    contentMode: .scaleAspectFill
                )
                .ignoresSafeArea()
                
                Image(status.rawValue)
                    .resizable()
                    .onAppear{
                        setupTimer()
                    }
                
                BubbleText(text: breathText, alignment: .vertical, textType: .big())
                    .padding(.top, 32)
                
                
            }
            //MARK: Additional
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color("SecondaryColorDark"))
            //MARK: Music Player
            VStack{
                Spacer()
                if let player = meditationVM.audioManager.player{
                    HStack(spacing: 12){
                        Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                        Slider(value: $meditationVM.value, in: 0...player.duration){ editing in
                            meditationVM.changeCurrentTimeSlider(editing: editing)
                        }
                        .tint(Color("CelticBlue"))
                        Text(DateComponentsFormatter.positional.string(from: player.duration) ?? "0:00")
                    }
                    .font(.caption)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 32)
                }
                
                //MARK: Button Stack
                HStack{
                    //MARK: Button backward
                    ControlButton(systemName: "gobackward.10", width: 60, height: 60) {
                        meditationVM.changeBackOrForward(isBackward: true)
                    }
                    //MARK: Play or pause button
                    ControlButton(systemName: !meditationVM.audioManager.isPlaying ? "play.fill" : "pause.fill", width: 60, height: 60) {
                        meditationVM.startPauseMusic()
                    }
                    .padding(.horizontal, 57)
                    //MARK: Button forward
                    ControlButton(systemName: "goforward.10", width: 60, height: 60) {
                        meditationVM.changeBackOrForward(isBackward: false)
                    }
                }
                .padding([.horizontal, .bottom])
                Spacer()
                
                //MARK: Continue Button
                PrimaryButton(text: "Continue", isFull: true) {
                    meditationVM.stopMusic()
                    invalidateTimer()
                    //TODO: Navigate to another path
                    
                    proceedToStoryIntro()
                }
            }
            .padding(.horizontal, 16)
            .background()
            .frame(maxHeight: UIScreen.main.bounds.height - 600)
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .padding(.top, -16)
            
            
        }
        .onAppear{
            //prepare music
            meditationVM.prepareMusic()
            meditationVM.startPauseMusic()
        }
        .onReceive(meditationVM.$timer) { _ in
            print("timer test")
            meditationVM.changeCurrentTimePlayerReceive()
        }
        .onDisappear{
            meditationVM.audioManager.stop()
        }
    }
    
    
    func proceedToStoryIntro() {
        pathStore.path.append(ViewPath.storyIntro(history))
    }
}


struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView(history: HistoryModel())
    }
}
