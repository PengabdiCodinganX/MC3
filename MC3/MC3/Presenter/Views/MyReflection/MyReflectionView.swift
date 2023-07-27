//
//  MyReflectionView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 28/07/23.
//

import SwiftUI

struct MyReflectionView: View {
    @StateObject private var viewModel: MyReflectionViewModel = MyReflectionViewModel()
    
    @State private var histories: [HistoryModel] = []
    
    var body: some View {
        ZStack {
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                List(histories) { history in
                    Card(date: history.createdTimestamp?.formatted() ?? "", textBody: history.problem ?? "")
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            Task {
                histories = try await viewModel.getHistories()
            }
        }
    }
}

struct MyReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        MyReflectionView()
    }
}
