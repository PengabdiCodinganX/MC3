//
//  BubbleText.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import SwiftUI

enum TextType{
    case big(size: CGFloat = 20)
    case middle(size: CGFloat = 15)
    case short(size: CGFloat = 10)
    
    var size: CGFloat {
        switch self {
        case .big(let size), .middle(let size), .short(let size):
            return size
        }
    }
}

struct BubbleText: View {
    var text: String
    var alignment: MascotAlignment
    var textType: TextType = .middle()
    
    var body: some View {
        Text(text)
            .font(Font.custom("SF Pro Rounded", size: textType.size))
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
