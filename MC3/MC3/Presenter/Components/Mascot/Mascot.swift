//
//  Mascot.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI

struct Mascot: View {
    var text: String
    var alignment: MascotAlignment
    var mascotImage: MascotImage = .face
    
    var body: some View {
        let layout = alignment == .horizontal ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

        layout {
            if alignment == .vertical && !text.isEmpty {
                BubbleText(
                    text: text,
                    alignment: alignment
                )
            }
            
            LottieView(lottieFile: "charachter-animation-lottie", loopMode: .loop,contentMode: .scaleAspectFill)

//            Image(mascotImage == .face ? "Mascot" : "Mascot-Half-Body")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(minWidth: alignment == .horizontal ? 128 : 256)
//                .padding()

            if alignment == .horizontal && !text.isEmpty {
                BubbleText(
                    text: text,
                    alignment: alignment,
                    textType: .short()
                )
            }
        }
        
    }
}

struct Mascot_Previews: PreviewProvider {
    static var previews: some View {
        Mascot(text: "dffwq ewqe qweqw eq deqweqw eqwekjl bnqwekljwqbne kljqwnel kqwn lenqwle nwqklen qwlken qwlk enlqwn eqww rdfqnwek jqwbne", alignment: .vertical)
    }
}
