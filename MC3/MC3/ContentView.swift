//
//  ContentView.swift
//



//  LionAnimation
//
//  Created by Muhammad Rezky on 15/07/23.

// import SwiftUI

// struct ContentView: View {
//     var text = "aiueo halo aku singa"
//     @State private var currentIndex = 0
//     @State private var currentCharacter: Character = " "
    
//     private var vowels: [Character] = ["a", "i", "u", "e", "o"]
//     var body: some View {
//          ZStack {
//              Image("basic-body")
//                  .resizable()
//                  .scaledToFit()
             
//              Image("a")
//                  .resizable()
//                  .scaledToFit()
//                  .opacity(currentCharacter == "a" ? 1 : 0)
//                  .animation(.easeIn(duration: 0.3))
//              Image("i")
//                  .resizable()
//                  .scaledToFit()
//                  .opacity(currentCharacter == "i" ? 1 : 0)
//                  .animation(.easeIn(duration: 0.3))
//              Image("u")
//                  .resizable()
//                  .scaledToFit()
//                  .opacity(currentCharacter == "u" ? 1 : 0)
//                  .animation(.easeIn(duration: 0.3))
//              Image("e")
//                  .resizable()
//                  .scaledToFit()
//                  .opacity(currentCharacter == "e" ? 1 : 0)
//                  .animation(.easeIn(duration: 0.3))
//              Image("o")
//                  .resizable()
//                  .scaledToFit()
//                  .opacity(currentCharacter == "o" ? 1 : 0)
//                  .animation(.easeIn(duration: 0.3))
//              Image(String(randomImageName()))
//                 .resizable()
//                 .scaledToFit()
//                 .opacity(!vowels.contains(currentCharacter) ? 1 : 0)
//          }
//          .padding()
//          .onAppear {
//              startTimer()
//          }
//      }
     
//      private func startTimer() {
//          Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//              if currentIndex < text.count {
//                  currentCharacter = text[text.index(text.startIndex, offsetBy: currentIndex)]
//                  currentIndex += 1
//              } else {
//                  currentIndex = 0
                 
//              }
//          }
//      }
    
//     private func randomImageName() -> String {
//         let randomNumber = Int.random(in: 1...2)
//         return "\(randomNumber)"
// //  TestLottie
// //
// //  Created by Muhammad Rezky on 20/07/23.

// import SwiftUI

// struct StageScene : Hashable{
//     let id: UUID = UUID()
//     let name: String
//     var textColor: Color = Color.black
//     var currentTextIndex: Int = 1
//     let text: [String]
// }

// struct PlayTextView: View {
//     @Binding var index: Int
//     @State var playedText: [String]
//     private var startPlayedTextCount: Int
//     var textColor: Color
    
//     init(index: Binding<Int>, textColor: Color) {
//         _index = index
//         _playedText = State(initialValue: scenes[index.wrappedValue].text)
//         self.startPlayedTextCount = scenes[index.wrappedValue].text.count
//         self.textColor = textColor
//     }
    
//     @State var timer: Timer?
    
//     private func setupTimer() {
//         highlightedText = 0
//         var playedTime = 0
//         timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
//             if !playedText.isEmpty {
//                 if(playedTime >= 1){
//                     withAnimation{
//                         playedText.remove(atOffsets: IndexSet(integer: 0))

//                     }
//                 }
//                 withAnimation{
//                     highlightedText = 1
//                 }
//                 playedTime += 1
//             } else {
//                 playedTime = 0
//             }
//         }
//     }
    
//     private func invalidateTimer() {
//         timer?.invalidate()
//         timer = nil
//     }
    

//     @State var highlightedText = 0
//     var body: some View {
//         VStack(spacing: 32){
//             ForEach(playedText.prefix(3), id: \.self){text in
//                 let textIndex : Int = playedText.firstIndex(of: text) ?? 0
//                 let opacity = textIndex == highlightedText ? 1.0 : 0.2
                
//                 Text(text)
//                     .font(.system(size: 20, weight: textIndex == highlightedText ? .bold : .regular, design: .rounded))
//                     .multilineTextAlignment(.center)
//                     .foregroundColor(textColor)
//                     .opacity(opacity)
//                     .animation(.default, value: text)
//             }
//         }
//         .onAppear{
//             setupTimer()
//         }
//         .onChange(of: index){_ in
//             invalidateTimer()
//             playedText = scenes[index].text
//             setupTimer()
//         }
//         .padding(.horizontal, 32)
//     }
// }


// struct ContentView: View {
//     @State var index = 0
//     @State var isAnimationVisible = true
    
    
//     var body: some View {
//         ZStack (alignment: .center){
//             Color.black
//                 .ignoresSafeArea(.all)
//                 .edgesIgnoringSafeArea(.all)
//             LottieView(lottieFile: scenes[index].name, loopMode: .loop)
//                 .ignoresSafeArea(.all)
//                 .edgesIgnoringSafeArea(.all)
//                 .animation(.easeIn(duration: 0.3), value: scenes[index].name)
//                 .opacity(isAnimationVisible ? 1 : 0)
//             VStack{
//                 ProgressView(value: 30, total: 100)
//                     .tint(.black)
//                 Spacer()
                
//                 PlayTextView(index: $index, textColor: scenes[index].textColor)
                
//                 Spacer()
//                 HStack{
//                     Spacer()
//                     Button{
//                         if(index < scenes.count-1){
//                             withAnimation(.easeIn(duration: 0.5)){
//                                 index += 1
//                             }
//                         } else {
//                             withAnimation(.easeIn(duration: 0.5)){
//                                 index = 0
//                             }
//                         }
//                     } label: {
//                         HStack{
//                             Text("Next")
//                             Image(systemName: "chevron.forward")
//                         }
//                     }
//                     .foregroundColor(scenes[index].textColor)
//                 }
//                 .padding(.horizontal, 32)
//             }
//         }
//         .onChange(of: index) { newIndex in
//             withAnimation(.easeInOut(duration: 0.3)) {
//                 isAnimationVisible = false
//             }
//             DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                 withAnimation(.easeInOut(duration: 0.3)) {
//                     isAnimationVisible = true
//                 }
//             }
//         }
//     }
// }


// var scenes : [StageScene] = [
//     StageScene(
//         name: "a-scene-1",
//         text: [
//             "Ini pertama Thomas Edis on, the brilliant inventor, faced countless obstacles and failures throughout his journey.",
//             "Ini kedua When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Ketiga Thomas Edison, the brilliant inventor, faced countless obstacles and failures throughout his journey.",
//             "Ini Keempat When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Kelima When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Keenam When he was working on inventing the electric light bulb, he encountered numerous.",
//         ]
//     ),
//     StageScene(
//         name: "a-scene-2",
//         textColor: Color.white,
//         text: [
//             "Ini pertama Thomas Edis on, the brilliant inventor, faced countless obstacles and failures throughout his journey.",
//             "Ini kedua When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Ketiga Thomas Edison, the brilliant inventor, faced countless obstacles and failures throughout his journey.",
//             "Ini Keempat When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Kelima When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Keenam When he was working on inventing the electric light bulb, he encountered numerous.",
//         ]
//     ),
//     StageScene(
//         name: "a-scene-3",
//         textColor: Color.black,
//         text: [
//             "Ini pertama Thomas Edis on, the brilliant inventor, faced countless obstacles and failures throughout his journey.",
//             "Ini kedua When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Ketiga Thomas Edison, the brilliant inventor, faced countless obstacles and failures throughout his journey.",
//             "Ini Keempat When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Kelima When he was working on inventing the electric light bulb, he encountered numerous.",
//             "Ini Keenam When he was working on inventing the electric light bulb, he encountered numerous.",
//         ]
//     ),
// ]


// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }
