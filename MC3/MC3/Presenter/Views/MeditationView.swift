//
//  MeditationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import SwiftUI
import Combine

enum BreatheStatus: String{
    case breatheIn = "breathe-in-mouth"
    case breatheOut = "breathe-out-mouth"
    case hold = "breathe-hold-mouth"
}

struct MeditationView: View {
    @StateObject var meditationVM: MeditationViewModel = MeditationViewModel()
    @State private var breathText: String = "Breathe in..."
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @State private var isFinished: Bool = false
    
    @State var status: BreatheStatus = BreatheStatus.breatheIn
    
    @State var timer: Timer?
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            switch status {
            case .breatheIn:
                status = .hold
            case .breatheOut:
                status = .breatheIn
            case .hold:
                status = .breatheOut
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
                
                BubbleText(text: "Breathe In", alignment: .vertical, textType: .big())
                    .padding(.top, 32)
                    
                
            }
            //MARK: Additional
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color("SecondaryColorDark"))
            //MARK: Music Player
            VStack{
                Spacer()
                HStack(spacing: 12){
                    Text("0:00")
                    Slider(value: $value, in: 0...60){ editing in
                        
                    }
                    .tint(Color("CelticBlue"))
                    Text("1:00")
                }
                .font(.caption)
                .padding(.bottom, 24)
                .padding(.horizontal, 32)
                
                //MARK: Button Stack
                HStack{
                    //MARK: Button backward
                    ControlButton(systemName: "gobackward.10", width: 60, height: 60) {
                        
                    }
                    //MARK: Play or pause button
                    ControlButton(systemName: "play.fill", width: 60, height: 60) {
                        
                    }
                    .padding(.horizontal, 57)
                    //MARK: Button forward
                    ControlButton(systemName: "goforward.10", width: 60, height: 60) {
                        
                    }
                }
                .padding([.horizontal, .bottom])
                Spacer()
                
                //MARK: Continue Button
                PrimaryButton(text: "Continue", isFull: true) {
                    print()
                }
            }
            .padding(.horizontal, 16)
            .background()
            .frame(maxHeight: UIScreen.main.bounds.height - 600)
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .padding(.top, -16)
            
            
        }
        
    }
}


struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
