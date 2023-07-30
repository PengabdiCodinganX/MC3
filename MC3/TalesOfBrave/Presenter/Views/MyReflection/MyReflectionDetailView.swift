//
//  MyReflectionDetailView.swift
//  MC3
//
//  Created by Muhammad Rezky on 28/07/23.
//

import SwiftUI

struct MyReflectionDetailView: View {
    @State var isMotivationExpanded: Bool = false
    @State var isReflectionExpanded: Bool = false
    @State var isProblemExpanded: Bool = true
    
    var history: HistoryModel
    @StateObject var vm = MyReflectionDetailViewModel()
    
    init(history: HistoryModel) {
        self.history = history
    }
    
    var body: some View {
            ZStack{
                Color("AccentColor")
                    .ignoresSafeArea()
                    .onAppear{
                        Task{
                            
                            await vm.initData(data: history)
                        }
                    }
                
                    ScrollView{
                VStack(spacing: 16){
                    DisclosureGroup("Related Motivation Story", isExpanded: $isMotivationExpanded) {
                        VStack {
                            Text(vm.story)
                                .font(.callout)
                                .onTapGesture {
                                    withAnimation{
                                        isMotivationExpanded.toggle()
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .tint(Color("SecondaryColorDark"))
                    DisclosureGroup("Your Reflection", isExpanded: $isReflectionExpanded) {
                        VStack {
                            Text(vm.reflection)
                                .font(.callout)
                                .onTapGesture {
                                    withAnimation{
                                        isReflectionExpanded.toggle()
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .tint(Color("SecondaryColorDark"))
                    DisclosureGroup("Your Problem", isExpanded: $isProblemExpanded) {
                        VStack {
                            Text(vm.problem)
                                .font(.callout)
                                .onTapGesture {
                                    withAnimation{
                                        isProblemExpanded.toggle()
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .tint(Color("SecondaryColorDark"))
                    Spacer()
                }
                
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .cornerRadius(16)
                
                .padding(24)
            }
        }
    }
}

//struct MyReflectionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyReflectionDetailView()
//    }
//}
