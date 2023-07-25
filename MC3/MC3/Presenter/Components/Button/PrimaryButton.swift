//
//  PrimaryButton.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var isFull: Bool = false
    
    let onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Text(text)
                .frame(maxWidth: isFull ? .infinity : nil)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color("SecondaryColor"))
        .buttonBorderShape(.capsule)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "text") {}
    }
}
