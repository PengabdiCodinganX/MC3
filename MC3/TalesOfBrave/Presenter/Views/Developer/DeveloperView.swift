//
//  DeveloperView.swift
//  TalesOfBrave
//
//  Created by Muhammad Adha Fajri Jonison on 30/07/23.
//

import SwiftUI

struct DeveloperView: View {
    @StateObject private var viewModel: DeveloperViewModel = DeveloperViewModel()
    
    @State private var introduction: String = ""
    @State private var problem: String = ""
    @State private var resolution: String = ""
    
    var body: some View {
        TextArea(placeholder: "Introduction", text: $introduction)
        TextArea(placeholder: "Problem", text: $problem)
        TextArea(placeholder: "Resolution", text: $resolution)
        
        PrimaryButton(text: "Save") {
            Task {
                try await viewModel.saveStory(introduction: introduction, problem: problem, resolution: resolution)
            }
        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
