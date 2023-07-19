//
//  MeditationView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 19/07/23.
//

import SwiftUI

struct MeditationView: View {
    @State private var value: Double = 0.0
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            //MARK: Timeline player
            HStack{
                Text("0:00")
                Slider(value: $value, in: 0...60)
                    .tint(.gray)
                Text("1:00")
            }
            .font(.caption)
            .padding()
        }
        .padding()
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
