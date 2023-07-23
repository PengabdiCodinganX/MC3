//
//  BubbleText.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import SwiftUI

struct BubbleText: View {
    var text: String
    var alignment: MascotAlignment
    
    var body: some View {
        Text(text)
            .font(Font.custom("SF Pro Rounded", size: alignment == .vertical ? 16 : 12))
            .kerning(1.4)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .lineSpacing(alignment == .vertical ? 8 : 5)
            .padding()
            .background(ChatBubble(alignment: alignment).fill(Color.white)) // Set the bubble color to gray
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct BubbleText_Previews: PreviewProvider {
    static var previews: some View {
        BubbleText(text: "test wqkeonwql ewq dqw d dwqknejwq lken qwlkne lqwknelqwkne lqkwnelk wqnelkqwn lekwqn elkqwn e lwqnel nqwlenwq lenqwlken qwlkne qwlkenqwlk enqwlken wqlken qwlkenqwlk neqwlkne qwlkne wlqkne lwqknel qwnelqwkne lkqwne lqwne lqwnelkwq nelqwkn elqwkne lqwknewq lkneqwlkne lqwkne qwlkne qwlkne wqlkne wlqke nwqlk neqwlk nrqwlkrnwqlkenwq lkenwqklwqeklwqnehq we qwnmel kqwml", alignment: .horizontal)
    }
}
