//
//  PlayBackControlButton.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import SwiftUI

struct ControlButton: View {
    var systemName: String = "play"
    var imageSize: CGFloat = 35
    var width: CGFloat = 80
    var height: CGFloat = 80
    var color: Color = .white
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
        .background(.black)
        .cornerRadius(100)

    }
}

struct ControlButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlButton(action: {})
    }
}
