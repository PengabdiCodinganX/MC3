//
//  KeyboardService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 24/07/23.
//

import Foundation
import SwiftUI
import Combine

class KeyboardService: ObservableObject {
    @Published var isKeyboardOpen = false
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        withAnimation(.spring()) {
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true }
                .assign(to: \.isKeyboardOpen, on: self)
                .store(in: &cancellableSet)
            
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
                .assign(to: \.isKeyboardOpen, on: self)
                .store(in: &cancellableSet)
        }
    }
}
