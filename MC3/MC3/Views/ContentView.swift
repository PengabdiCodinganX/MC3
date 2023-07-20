//
//  ContentView.swift
//  MC3
//
//  Created by Vincent Gunawan on 11/07/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pathStore: PathStore
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            SplashView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
