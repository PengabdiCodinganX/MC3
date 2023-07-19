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
    
    var body: some View {
        let layout = alignment == .horizontal ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

        layout {
            if alignment == .vertical && !text.isEmpty {
                BubbleText(
                    text: text,
                    alignment: alignment
                )
            }

            Image("Mascot")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: alignment == .horizontal ? 128 : 256)

            if alignment == .horizontal && !text.isEmpty {
                BubbleText(
                    text: text,
                    alignment: alignment
                )
            }
        }
//        switch alignment {
//        case .horizontal:
//            HStack {
//                Image("Mascot")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(minWidth: 128)
//
//                if !text.isEmpty {
//                    BubbleText(
//                        text: text,
//                        alignment: alignment
//                    )
//                }
//
//
//            }
//        case .vertical:
//            VStack {
//                if !text.isEmpty {
//                    BubbleText(
//                        text: text,
//                        alignment: alignment
//                    )
//                }
//
//                Image("Mascot")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(minWidth: 256)
//            }
//        }
        
    }
}

struct Mascot_Previews: PreviewProvider {
    static var previews: some View {
        Mascot(text: "dffwq ewqe qweqw eq deqweqw eqwekjl bnqwekljwqbne kljqwnel kqwn lenqwle nwqklen qwlken qwlk enlqwn eqww rdfqnwek jqwbne", alignment: .horizontal)
    }
}
