//
//  SecondaryButton.swift
//  MC3
//
//  Created by Muhammad Rezky on 25/07/23.
//

import SwiftUI

struct SecondaryButton: View {
    var text: String
    var isFull: Bool = false
    
    let onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Text(text)
                .foregroundColor(Color("SecondaryColor"))
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: isFull ? .infinity : nil, maxHeight: 44)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color("AccentColor"))
        .buttonBorderShape(.capsule)
    }
}


struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(text: "text") {}
    }
}
