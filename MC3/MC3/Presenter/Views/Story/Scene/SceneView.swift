//
//  SceneView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import SwiftUI

struct StageScene : Hashable{
    let id: UUID = UUID()
    var name: String?
    var textColor: Color = Color.black
    var currentTextIndex: Int = 1
    var text: [String]?
    var soundList: [Data]?
}

struct PlayTextView: View {
    @StateObject private var viewModel: PlayTextViewModel = PlayTextViewModel()
    
    var textColor: Color
    var scenes: [StageScene]
    
    let onCompletion: () -> Void
    
    @State var playedText: [String]
    @State var soundList: [Data]
    
    @Binding var index: Int
    
    init(index: Binding<Int>, textColor: Color, scenes: [StageScene], onCompletion: @escaping () -> Void) {
        _index = index
        _playedText = State(initialValue: scenes[index.wrappedValue].text ?? [])
        _soundList = State(initialValue: scenes[index.wrappedValue].soundList ?? [])
        self.textColor = textColor
        self.scenes = scenes
        self.onCompletion = onCompletion
    }
    
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var isTimer: Bool = true
    
    @State var highlightedText = 0
    @State var playedTime: Int = 0
    
    func changeHighlightedText(){
        print("[playedTime]", playedTime)
        print("[playedText]", playedText)
        print("[soundList]", soundList)

        if (!playedText.isEmpty) {
            if(playedTime >= 1){
                withAnimation{
                    playedText.remove(atOffsets: IndexSet(integer: 0))
                    soundList.remove(atOffsets: IndexSet(integer: 0))
                }
            }
            withAnimation{
                highlightedText = playedText.count == 1 ? 0 : 1
            }
            playedTime += 1
        } else {
            playedTime = 0
        }
    }
    
    var body: some View {
        VStack(spacing: 32){
            ForEach(playedText.prefix(3), id: \.self){text in
                let textIndex : Int = playedText.firstIndex(of: text) ?? 0
                let opacity = textIndex == highlightedText ? 1.0 : 0.2
                
                Text(text)
                    .font(.system(size: textIndex == highlightedText ? 20 : 21, weight: textIndex == highlightedText ? .bold : .regular, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .opacity(opacity)
                    .animation(.default, value: text)
            }
        }
        .padding(.horizontal, 32)
        .onAppear{
            playAudio()
        }
        .onChange(of: viewModel.isPlaying, perform: { isPlaying in
            print("[onChange][isPlaying]", isPlaying)
            if !isPlaying {
                showNextText()
                playAudio()
            }
        })
        .onReceive(timer, perform: { timer in
            print("[onReceive][timer]", timer)
            print("[onReceive][viewModel.isPlaying]", viewModel.isPlaying)
            
            if !viewModel.isPlaying {
                showNextText()
                playAudio()
            }
        })
        .onChange(of: index){ _ in
            changeScene()
        }
        .onDisappear {
            stopAudio()
            timer.upstream.connect().cancel()
        }
    }
    
    private func stopAudio() {
        viewModel.stopAudio()
    }
    
    func changeScene() {
        highlightedText = 0
        playedTime = 0
        playedText = scenes[index].text ?? []
        soundList = scenes[index].soundList ?? []
        playAudio()
    }
    
    private func playAudio() {
        print("[playAudio]", soundList)

        guard highlightedText < soundList.count - 1 else {
            guard playedText.isEmpty else {
                print("[playAudio][playedText]", playedText)

                showNextText()
                viewModel.playAudio(data: soundList[highlightedText])
                return
            }
            
            guard index >= scenes.count - 1 else {
                print("[playAudio][index]", index)
                print("[playAudio][scenes.count]", scenes.count)
                
                withAnimation(.spring()) {
                    index += 1
                }
                
                return
            }

            onCompletion()
            return
        }
        
        

        viewModel.playAudio(data: soundList[highlightedText])
    }

    
    private func showNextText() {
        changeHighlightedText()
    }
}


struct SceneView: View {
    var scenes : [StageScene]
    
    @State var index = 0
    @State var isAnimationVisible = true
    @StateObject var animationController = LottieController()
    
    let onCompletion: () -> Void
    
    var body: some View {
        ZStack (alignment: .center){
            LottieView(controller: animationController,lottieFile: scenes[index].name ?? "", loopMode: .loop)
                .ignoresSafeArea(.all)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring(), value: index)
                .transition(.opacity)
                .id(index)
            VStack{
                ProgressView(value: min(max(0, Double(scenes[index].currentTextIndex)), Double((scenes[index].text?.count ?? 0) - 1)),
                             total: Double((scenes[index].text?.count ?? 0) - 1))
                .tint(.black)
                Spacer()
                
                PlayTextView(
                    index: $index,
                    textColor: scenes[index].textColor,
                    scenes: scenes, onCompletion: onCompletion)
                
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        if(index < scenes.count-1){
                            withAnimation(.spring()) {
                                index += 1
                            }
                        } else {
                            onCompletion()
                        }
                    } label: {
                        HStack{
                            Text("Next")
                            Image(systemName: "chevron.forward")
                        }
                    }
                    .foregroundColor(scenes[index].textColor)
                }
                .padding(.horizontal, 32)
            }
        }
        .onChange(of: index) { newIndex in
            withAnimation(.easeInOut(duration: 0.3)) {
                isAnimationVisible = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isAnimationVisible = true
                }
            }
        }
    }
}

struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView(scenes: [
            StageScene(name: "a-scene-1", text: ["John doe john jode ndeodjn djknwqeqwe", "d kqwoineklwqnelk qwnelkqwnmjdpoc nso ifbeoiqwehwqoejqwojfdpsfmds"]),
            StageScene(name: "a-scene-2", text: ["test"]),
            StageScene(name: "a-scene-3", text: ["test"])
        ], onCompletion: {})
    }
}
