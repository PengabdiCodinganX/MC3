//
//  Mascot.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI
import AVKit

struct TextTrack: Equatable {
    let text: String
    let track: String?
}

struct Mascot: View {
    @StateObject private var viewModel: MascotViewModel = MascotViewModel()
    
    var mascotText: [TextTrack]
    var alignment: MascotAlignment
    var mascotImage: MascotImage = .show
    var mascotContentMode: UIView.ContentMode = .scaleAspectFill
    
    @State private var texts: [String] = []
    @State private var currentIndex = 0
    
    var body: some View {
        let layout = alignment == .horizontal ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        
        return layout {
            
            if alignment == .vertical && !texts.isEmpty {
                ForEach(texts.indices, id: \.self){index in
                    BubbleText(text: texts[index], alignment: .vertical, showPointer: index == texts.count-1, textAlignment: .leading)
                        .opacity(index == texts.count-1 ? 1 : 0.5)
                        .padding(.bottom, 8)
                }
                
                if mascotImage == .show {
                    LottieView(lottieFile: "charachter-animation-lottie", loopMode: .loop, contentMode: mascotContentMode)
                }
            }
            
            
            if alignment == .horizontal && !texts.isEmpty {
                if mascotImage == .show {
                    LottieView(lottieFile: "charachter-animation-lottie", loopMode: .loop, contentMode: .scaleAspectFit)
                        .frame(width: 100, height: 160)
                }
                
                ForEach(texts.indices, id: \.self){index in
                    BubbleText(
                        text: texts[index],
                        alignment: .horizontal,
                        showPointer: index == texts.count-1,
                        expand: true,
                        textAlignment: .leading
                    )
                    
                    .opacity(index == texts.count-1 ? 1 : 0.5)
                    .padding(.bottom, 8)
                    .padding()
                }
            }
        }
        .onAppear {
            print("[onAppear][textList]", mascotText)
            
            withAnimation(.spring()) {
                texts = []
                currentIndex = 0
            }
            
            guard !mascotText.isEmpty else {
                return
            }
            
            print("[onAppear][currentIndex]", currentIndex)
            print("[onAppear][textList.count]", mascotText.count)
            guard currentIndex < mascotText.count else {
                return
            }
            
            
            showText(textList: mascotText)
            playAudio(textList: mascotText)
        }
        .onChange(of: mascotText, perform: { textList in
            print("[onChange][textList]", textList)
            
            withAnimation(.spring()) {
                texts = []
                currentIndex = 0
            }
            
            guard !textList.isEmpty else {
                return
            }
            
            print("[onChange][currentIndex]", currentIndex)
            print("[onChange.textList.count]", textList.count)
            guard currentIndex < textList.count else {
                return
            }
            
            showText(textList: textList)
            playAudio(textList: textList)
        })
        .onChange(of: viewModel.isPlaying) { isPlaying in
            print("[viewModel.isPlaying]", isPlaying)
            guard !isPlaying else {
                return
            }
            
            guard currentIndex < mascotText.count - 1 else {
                return
            }
            
            withAnimation(.spring()) {
                currentIndex += 1
            }
            
            showText(textList: mascotText)
            playAudio(textList: mascotText)
        }
        .onDisappear {
            viewModel.stopAudio()
        }
    }
    
    private func showText(textList: [TextTrack]) {
        print("[showText][textList]", textList)
        print("[showText][currentIndex]", currentIndex)
        guard !textList.isEmpty else {
            return
        }
        print("[showText][Array(textList.keys)[currentIndex]", textList[currentIndex].text)
        
        let text: String = textList[currentIndex].text
        print("[showText][text]", text)
        
        withAnimation(.spring()) {
            texts.append(text)
        }
    }
    
    private func playAudio(textList: [TextTrack]) {
        guard !textList.isEmpty else {
            return
        }
        
        guard let track: String = textList[currentIndex].track else {
            return
        }
        
        guard !track.isEmpty else {
            return
        }
        print("[playAudio][track]", track)
        
        viewModel.playAudio(track: track)
    }
}

struct Mascot_Previews: PreviewProvider {
    static var previews: some View {
        Mascot(mascotText: [TextTrack(text: "test", track: "")], alignment: .vertical)
    }
}
