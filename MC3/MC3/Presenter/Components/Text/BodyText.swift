//
//  BodyText.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 17/07/23.
//

import SwiftUI

struct BodyText: View {
    var text: String
    
    var body: some View {
        Text(text)
          .font(Font.custom("SF Pro Rounded", size: 16))
          .kerning(0.85)
          .foregroundColor(.black)
    }
}

struct BodyText_Previews: PreviewProvider {
    static var previews: some View {
        BodyText(text: "Stefasfsa")
    }
}
