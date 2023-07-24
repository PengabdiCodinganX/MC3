//
//  MeditationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import SwiftUI

struct MeditationView: View {
    @StateObject var meditationVM: MeditationViewModel = MeditationViewModel()
    
    @State private var breathText: String = "Breathe in..."
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                //MARK: Mascot with chat bubble
                BubbleText(text: breathText, alignment: .vertical, textType: .big(size: 28))
                    .padding()
                
                Image("Mascot-Half-Body")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                
                //MARK: Music Player
                VStack{
                    if let player = meditationVM.audioManager.player{
                        HStack{
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            Slider(value: $meditationVM.value, in: 0...player.duration){ editing in
                                meditationVM.changeCurrentTimeSlider(editing: editing)
                            }
                            .tint(Color("CelticBlue"))
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .padding()
                    }
                    
                    
                    //MARK: Button Stack
                    HStack{
                        Spacer()
                        //MARK: Button backward
                        ControlButton(systemName: "gobackward.10", width: 60, height: 60) {
                            meditationVM.changeBackOrForward(isBackward: true)
                        }
                        Spacer()
                        //MARK: Play or pause button
                        ControlButton(systemName: "play.fill", width: 60, height: 60) {
                            meditationVM.startPauseMusic()
                        }
                        Spacer()
                        //MARK: Button forward
                        ControlButton(systemName: "goforward.10", width: 60, height: 60) {
                            meditationVM.changeBackOrForward(isBackward: false)
                        }
                        Spacer()
                    }
                    .padding([.horizontal, .bottom])
                    
                    //MARK: Continue Button
                    PrimaryButton(text: "Continue", isFull: true) {
                        meditationVM.stopMusic()
                        //TODO: Navigate to another path
                    }
                }
                .padding([.horizontal, .bottom], 16)
                .background()
            }
        }
        .onAppear{
            //prepare music
            meditationVM.prepareMusic()
        }
        .onReceive(meditationVM.$timer) { _ in
            print("timer test")
            meditationVM.changeCurrentTimePlayerReceive()
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
