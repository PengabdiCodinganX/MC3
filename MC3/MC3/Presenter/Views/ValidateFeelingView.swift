//
//  StoryIntroductionView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import SwiftUI

struct ValidateFeelingView: View {
    @EnvironmentObject private var pathStore: PathStore
    @State var timer: Timer?
    @State private var currentIndex = 0
//    @State private var texts: [String] = [].reversed()
    
    var body: some View {
        ZStack {
            Color("AccentColor").edgesIgnoringSafeArea(.all)
                .onAppear{
//                    setupTimer()
                }
            VStack(spacing: 0){
                Spacer()
                VStack{
                    Mascot(textList: Constant().problemDataTwo, alignment: .vertical)
                }
                .padding([.leading, .top, .trailing], 32)
                HStack{
                    Button(action: {}){
                        Text("Not now")
                            .underline().foregroundColor(.black)
                    }
                    Spacer()
                    PrimaryButton(text: " Continue ") {
                        proceedToStoryRecap()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .background(.white)
            }
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
