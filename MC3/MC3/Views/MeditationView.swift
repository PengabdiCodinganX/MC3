//
//  MeditationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import SwiftUI

struct MeditationView: View {
    @EnvironmentObject var audioManager: AudioManager
    @StateObject var meditationVM = MeditationViewModel(meditation: MeditationModel.data)
    
    let timer = Timer
        .publish(every: 0.5, on:.main, in: .common).autoconnect()
    
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @State private var isFinished: Bool = false
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            //MARK: Timeline player
            if let player = audioManager.player{
                HStack{
                    Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                    Slider(value: $value, in: 0...player.duration){ editing in
                        
                        isEditing = editing
                        if !editing{
                            player.currentTime = value
                        }
                        
                    }
                    .tint(.gray)
                    Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                }
                .font(.caption)
                .padding()
                
                //MARK: Button Stack
                HStack{
                    Spacer()
                    //MARK: Button backward
                    ControlButton(systemName: "gobackward.10", width: 60, height: 60) {
                        player.currentTime -= 10
                    }
                    Spacer()
                    //MARK: Play or pause button
                    ControlButton(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill", width: 60, height: 60) {
                        audioManager.playPause()
                    }
                    Spacer()
                    //MARK: Button forward
                    ControlButton(systemName: "goforward.10", width: 60, height: 60) {
                        player.currentTime += 10
                    }
                    Spacer()
                }
                .padding()
            }
            
            
            Button("Continue") {
                audioManager.stop()
                self.timer.upstream.connect().cancel()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear{
            audioManager.startPlayer(track: meditationVM.meditation.track, isPreview: true)
        }
        .onReceive(timer){ _ in
            guard let player = audioManager.player, !isEditing else { return }
            value = player.currentTime
            print(value)
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: MeditationModel.data)
    
    static var previews: some View {
        MeditationView(meditationVM: meditationVM)
            .environmentObject(AudioManager())
    }
}
