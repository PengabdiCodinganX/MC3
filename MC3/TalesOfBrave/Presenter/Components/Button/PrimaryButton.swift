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
    var isLoading: Bool = false
    
    let onClick: () -> Void
    
    var body: some View {
        Button {
            guard !isLoading else {
                return
            }
            
            onClick()
        } label: {
            if isLoading {
                ProgressView()
                    .tint(.white)
                    .progressViewStyle(.circular)
                    .frame(maxWidth: isFull ? .infinity : nil, minHeight: 44)
            } else {
                Text(text)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: isFull ? .infinity : nil, minHeight: 44)
            }
        }
        .animation(.spring(), value: isLoading)
        .buttonStyle(.borderedProminent)
        .tint(Color("SecondaryColor"))
        .buttonBorderShape(.capsule)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "text", isFull: true, isLoading: true) {}
    }
}
