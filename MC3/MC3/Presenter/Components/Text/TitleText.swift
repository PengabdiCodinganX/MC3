//
//  TitleText.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 17/07/23.
//

import SwiftUI

struct TitleText: View {
    var text: String
    
    var body: some View {
        Text(text)
          .font(Font.custom("SF Pro Rounded", size: 28))
          .kerning(1.4)
          .foregroundColor(.black)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "test")
    }
}
