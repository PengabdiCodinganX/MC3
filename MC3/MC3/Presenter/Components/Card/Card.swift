//
//  Card.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 28/07/23.
//

import SwiftUI

struct Card: View {
    var date: String
    var textBody: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(date)
            Text(textBody)
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(date: "17 03 2202", textBody: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitat")
    }
}
