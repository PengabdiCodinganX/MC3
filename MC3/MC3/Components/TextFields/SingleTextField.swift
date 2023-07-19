//
//  TextField.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import SwiftUI

struct SingleTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
            TextField("fwqknqw", text: $text)
            .textFieldStyle(.roundedBorder)
                 
        
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        SingleTextField(placeholder: "text", text: .constant(""))
    }
}
