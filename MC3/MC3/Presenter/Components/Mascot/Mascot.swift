//
//  Mascot.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI

struct Mascot: View {
    @StateObject var audioManager: AudioManager = AudioManager()
    
    var textList: [String : String?]
    var alignment: MascotAlignment
    var mascotImage: MascotImage = .face
    
    @State private var texts: [String] = []
    @State private var currentIndex = 0
    
    var body: some View {
        let layout = alignment == .horizontal ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

        layout {
            if alignment == .vertical && !texts.isEmpty {
                ForEach(texts.indices, id: \.self){index in
                    BubbleText(text: texts[index], alignment: .vertical, showPointer: index == texts.count-1, textAlignment: .leading)
                        .opacity(index == texts.count-1 ? 1 : 0.5)
                        .padding(.bottom, 8)
                }
            }
            
            LottieView(lottieFile: "charachter-animation-lottie", loopMode: .loop, contentMode: .scaleAspectFill)
                .frame(idealHeight: alignment == .vertical ? 270 : 100)

            if alignment == .horizontal && !texts.isEmpty {
                ForEach(texts.indices, id: \.self){index in
                    BubbleText(text: texts[index], alignment: .horizontal, showPointer: index == texts.count-1, textAlignment: .leading)
                        .opacity(index == texts.count-1 ? 1 : 0.5)
                        .padding(.bottom, 8)
                        .padding()
                }
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                texts = []
                currentIndex = 0
            }
            
            guard !textList.isEmpty else {
                return
            }
            
            guard currentIndex < textList.count else {
                return
            }
            

            showText()
            playAudio()
        }
        .onChange(of: audioManager.isPlaying) { isPlaying in
            print("[audioManager.isPlaying]", isPlaying)
            guard !isPlaying else {
                return
            }
            
            guard currentIndex < textList.count - 1 else {
                return
            }
            
            withAnimation(.spring()) {
                currentIndex += 1
            }
            
            showText()
            playAudio()
        }
        .onDisappear {
            audioManager.stop()
        }
    }
    
    private func showText() {
        print("[showText][currentIndex]", currentIndex)
        print("[showText][Array(textList.keys)[currentIndex]", Array(textList.keys)[currentIndex])
        guard !Array(textList.keys)[currentIndex].isEmpty else {
            return
        }
        
        let text: String = Array(textList.keys)[currentIndex]
        print("[showText][text]", text)
        
        withAnimation(.spring()) {
            texts.append(text)
        }
    }
    
    private func playAudio() {
        guard Array(textList.values)[currentIndex] != nil else {
                return
        }
        
        guard let track: String = Array(textList.values)[currentIndex] else {
            return
        }
        
        guard !track.isEmpty else {
            return
        }
        print("[playAudio][track]", track)
        
        audioManager.startPlayer(track: track)
    }
}

struct Mascot_Previews: PreviewProvider {
    static var previews: some View {
        Mascot(textList: Constant().problemDataTwo, alignment: .horizontal)
    }
}
