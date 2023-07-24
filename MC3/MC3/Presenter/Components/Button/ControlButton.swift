//
//  ControlButton.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 24/07/23.
//

import SwiftUI

struct ControlButton: View {
    var systemName: String = "play.fill"
    var imageSize: CGFloat = 35
    var width: CGFloat = 80
    var height: CGFloat = 80
    var color: Color = Color("CelticBlue")
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(height: imageSize)
                .tint(color)
                .padding(16)
        }
        .frame(width: width, height: height)
        .background(Color("Bubbles"))
        .cornerRadius(100)

    }
}

struct ControlButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlButton(action: {})
    }
}
