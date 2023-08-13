//
//  MyReflectionView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 28/07/23.
//

import SwiftUI

struct MyReflectionView: View {
    @EnvironmentObject private var pathStore: PathStore
    @StateObject private var viewModel: MyReflectionViewModel = MyReflectionViewModel()
    
    @State private var histories: [HistoryModel] = []
    
    var body: some View {
        ZStack{
            
            Color("AccentColor")
                .ignoresSafeArea()
            ScrollView{
                ForEach(histories) { history in
                    
                    Button{
                        pathStore.navigateToView(viewPath: .storyLogDetail(history))
                    } label: {
                        
                        VStack(alignment: .leading, spacing: 24){
                            VStack(alignment: .leading, spacing: 4){
                                Text("Problem")
                                    .font(.caption)
                                Text("\(history.problem ?? "")")
                                    .font(.callout)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(5)
                                    .truncationMode(.tail)
                                
                            }
                            VStack(alignment: .leading, spacing: 4){
                                Text("Reflection")
                                    .font(.caption)
                                Text("\(history.reflection ?? "")")
                                    .font(.callout)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(5)
                                    .truncationMode(.tail)
                            }
                            HStack{
                                Text("Jul 11")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("View Detail")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .foregroundColor(.black)
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .cornerRadius(16)
                        .padding(.bottom, 16)
                    }
                }
            }
            .padding(24)
                    .onAppear {
                        Task {
                            histories = try await viewModel.getHistories()
                            print(histories)
                        }
                    }
            
            Spacer()
        }
        .navigationTitle("My Reflection")
        //        ZStack {
        //            Color("AccentColor").edgesIgnoringSafeArea(.all)
        //
        //            VStack {
        //                List(histories) { history in
        //                    Card(date: history.createdTimestamp?.formatted() ?? "", textBody: history.problem ?? "")
        //                }
        //                .listStyle(.plain)
        //            }
        //        }
        //        .onAppear {
        //            Task {
        //                histories = try await viewModel.getHistories()
        //            }
        //        }
    }
}

struct MyReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        MyReflectionView()
    }
}
