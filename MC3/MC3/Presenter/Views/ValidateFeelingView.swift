//
//  StoryIntroductionView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct ValidateFeelingView: View {
    @EnvironmentObject private var pathStore: PathStore
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
    var body: some View {
        ZStack {
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(introduceData.indices, id: \.self) { index in
                                BubbleText(text: introduceData[index], alignment: .vertical)
                                    .padding(.bottom, 12)
                                    .opacity(currentIndex >= index ? 1: 0)
                            }
                        }
                        .onReceive(timer, perform: { _ in
                            withAnimation(.easeInOut(duration: 0.5)) {
                                currentIndex += 1
                                proxy.scrollTo(currentIndex, anchor: .top) // Scroll to the next index
                            }
                            
                            guard currentIndex != 2 else {
                                timer.upstream.connect().cancel()
                                return
                            }
                        })
                    }
                    .frame(height: 320)
                }
                
                Image("Mascot-Half-Body")
                    .resizable()
                    .scaledToFit()
                Spacer()
                HStack{
                    Button(action: { }){
                        Text("Not now")
                        .underline().foregroundColor(.black)
                    }
                    Spacer()
                    PrimaryButton(text: "Continue") {
                        proceedToStoryRecap()
                    }
                }
                .padding([.leading, .trailing])
            }
            .padding()
        }
    }
    
    func proceedToStoryRecap() {
        pathStore.navigateToView(viewPath: .storyRecap)
    }
}

struct ValidateFeelingView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateFeelingView()
    }
}
