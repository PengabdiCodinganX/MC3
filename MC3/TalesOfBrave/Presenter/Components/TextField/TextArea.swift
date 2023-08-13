//
//  CustomTextArea.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 24/07/23.
//

import Foundation
import SwiftUI

struct TextArea: View {
    var placeholder: String
    @Binding var text: String
    @FocusState private var focused: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            //MARK: TextEditor
            TextEditor(text: $text)
                .padding(16)
                .scrollContentBackground(.hidden)
                .background(Color("EditorColor"))
                .cornerRadius(16)
                .focused($focused)

            
            
            if text.isEmpty {
                Text(placeholder)
                    .padding(24)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        focused = true
                    }
            }
            
        }
        .frame(height: 180)
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea(placeholder: "Your name...", text: .constant("test"))
    }
}
