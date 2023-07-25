//
//  PathStore.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import Foundation
import SwiftUI

class PathStore: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func navigateToView(viewPath: ViewPath) {
        path.append(viewPath)
    }
}
