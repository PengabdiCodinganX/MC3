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
    var showPointer: Bool = true
    var expand: Bool = false
    var textAlignment: TextAlignment = .center
    
    var body: some View {
        
        if alignment == .vertical {
            VStack(spacing: 0){
                if expand {
                    Text(text)
                        .font(Font.custom("SF Pro Rounded", size: textType.size))
                        .foregroundColor(.black)
                        .multilineTextAlignment(textAlignment)
                        .lineSpacing(alignment == .vertical ? 8 : 5)
                        .padding()
                        .background(.white)
                        .cornerRadius(16)
                } else {
                    Text(text)
                        .font(Font.custom("SF Pro Rounded", size: textType.size))
                        .foregroundColor(.black)
                        .multilineTextAlignment(textAlignment)
                        .lineSpacing(alignment == .vertical ? 8 : 5)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: (textAlignment == .leading) ? .leading : .center)
                        .background(.white)
                        .cornerRadius(16)
                }
                if showPointer {
                    Image("triangle-vertical")
                }
            }
        } else {
            HStack(spacing: 0){
                if showPointer {
                    Image("triangle-horizontal")
                }
                Text(text)
                    .font(Font.custom("SF Pro Rounded", size: textType.size))
                    .foregroundColor(.black)
                    .multilineTextAlignment(textAlignment)
                    .lineSpacing(alignment == .vertical ? 8 : 5)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                
            }
        }
        
        //            .background(ChatBubble(alignment: alignment).fill(Color.white)) // Set the bubble color to gray
        //            .fixedSize(horizontal: false, vertical: true)
    }
}

struct BubbleText_Previews: PreviewProvider {
    static var previews: some View {
        BubbleText(text: "test wqkeonwql ewq dqw d dwqknejwq lken qwlkne lqwknelqwkne lqkwnelk wqnelkqwn lekwqn elkqwn e lwqnel nqwlenwq lenqwlken qwlkne qwlkenqwlk enqwlken wqlken qwlkenqwlk neqwlkne qwlkne wlqkne lwqknel qwnelqwkne lkqwne lqwne lqwnelkwq nelqwkn elqwkne lqwknewq lkneqwlkne lqwkne qwlkne qwlkne wqlkne wlqke nwqlk neqwlk nrqwlkrnwqlkenwq lkenwqklwqeklwqnehq we qwnmel kqwml", alignment: .horizontal)
    }
}
