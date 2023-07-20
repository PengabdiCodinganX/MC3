//
//  MenuButton.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import SwiftUI

struct MenuButton: View {
    var text: String
    var menuButtonType: MenuButtonType
    
    let onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack {
                Text(text)
                Image(systemName: "chevron.right")
            }
            .frame(maxWidth: .infinity, maxHeight: menuButtonType == .big ? 256 : 128)  // Fill height
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 16))
        .foregroundColor(.black)
        
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(text: "test eqwklne lkqwneqwlkmdm wlqknewqklen dmqwlkdnm wqlkme nqwlekmdqs dlnasdlk mwqel", menuButtonType: .big) { }
    }
}
