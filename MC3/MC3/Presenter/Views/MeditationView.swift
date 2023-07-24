//
//  MeditationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import SwiftUI
import Combine

struct MeditationView: View {
    @StateObject var meditationVM: MeditationViewModel = MeditationViewModel()
    
    @State private var breathText: String = "Breathe in..."
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @State private var isFinished: Bool = false
    
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
                    HStack{
                        Text("0:00")
                        Slider(value: $value, in: 0...60){ editing in
                            
                            //                            isEditing = editing
                            //                            if !editing{
                            //                                player.currentTime = value
                            //                            }
                        }
                        .tint(Color("CelticBlue"))
                        Text("1:00")
                    }
                    .font(.caption)
                    .padding()
                    
                    //MARK: Button Stack
                    HStack{
                        Spacer()
                        //MARK: Button backward
                        ControlButton(systemName: "gobackward.10", width: 60, height: 60) {
                            
                        }
                        Spacer()
                        //MARK: Play or pause button
                        ControlButton(systemName: "play.fill", width: 60, height: 60) {
                            
                        }
                        Spacer()
                        //MARK: Button forward
                        ControlButton(systemName: "goforward.10", width: 60, height: 60) {
                            
                        }
                        Spacer()
                    }
                    .padding([.horizontal, .bottom])
                    
                    //MARK: Continue Button
                    PrimaryButton(text: "Continue", isFull: true) {
                        print()
                    }
                }
                .padding([.horizontal, .bottom], 16)
                .background()
            }
        }
        .onAppear{
            
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
