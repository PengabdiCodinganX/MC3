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
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            //MARK: TextEditor
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .background(Color("EditorColor"))
                .cornerRadius(16)
                .padding()
            
            if text.isEmpty {
                Text(placeholder)
                    .padding(.top, 24)
                    .padding(.leading, 20)
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 200)
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea(placeholder: "Your name...", text: .constant("test"))
    }
}
