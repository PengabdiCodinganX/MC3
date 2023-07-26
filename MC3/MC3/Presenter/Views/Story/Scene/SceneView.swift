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
}

struct PlayTextView: View {
    @Binding var index: Int
    @State var playedText: [String]
    private var startPlayedTextCount: Int
    var textColor: Color
    var scenes: [StageScene]
   
    init(index: Binding<Int>, textColor: Color, scenes: [StageScene]) {
        _index = index
        _playedText = State(initialValue: scenes[index.wrappedValue].text ?? [])
        self.startPlayedTextCount = scenes[index.wrappedValue].text?.count ?? 0
        self.textColor = textColor
        self.scenes = scenes
    }
   
    @State var timer: Timer?
   
    private func setupTimer() {
        highlightedText = 0
        var playedTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            if !playedText.isEmpty {
                if(playedTime >= 1){
                    withAnimation{
                        playedText.remove(atOffsets: IndexSet(integer: 0))

                    }
                }
                withAnimation{
                    highlightedText = 1
                }
                playedTime += 1
            } else {
                playedTime = 0
            }
        }
    }
   
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
   

    @State var highlightedText = 0
    var body: some View {
        VStack(spacing: 32){
            ForEach(playedText.prefix(3), id: \.self){text in
                let textIndex : Int = playedText.firstIndex(of: text) ?? 0
                let opacity = textIndex == highlightedText ? 1.0 : 0.2
               
                Text(text)
                    .font(.system(size: 20, weight: textIndex == highlightedText ? .bold : .regular, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .opacity(opacity)
                    .animation(.default, value: text)
            }
        }
        .onAppear{
            setupTimer()
        }
        .onChange(of: index){_ in
            invalidateTimer()
            playedText = scenes[index].text ?? []
            setupTimer()
        }
        .padding(.horizontal, 32)
    }
}


struct SceneView: View {
    @State var index = 0
    @State var isAnimationVisible = true
    
    var scenes : [StageScene]
   
   
    var body: some View {
        ZStack (alignment: .center){
            Color.black
                .ignoresSafeArea(.all)
                .edgesIgnoringSafeArea(.all)
            LottieView(lottieFile: scenes[index].name ?? "", loopMode: .loop)
                .ignoresSafeArea(.all)
                .edgesIgnoringSafeArea(.all)
                .animation(.easeIn(duration: 0.3), value: scenes[index].name)
                .opacity(isAnimationVisible ? 1 : 0)
            VStack{
                ProgressView(value: 30, total: 100)
                    .tint(.black)
                Spacer()
               
                PlayTextView(index: $index, textColor: scenes[index].textColor, scenes: scenes)
               
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        if(index < scenes.count-1){
                            withAnimation(.easeIn(duration: 0.5)){
                                index += 1
                            }
                        } else {
                            withAnimation(.easeIn(duration: 0.5)){
                                index = 0
                            }
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
       SceneView(scenes: [])
   }
}
