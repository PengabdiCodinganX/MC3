//
//  HomeViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import Foundation
import SwiftUI
import AVFAudio

@MainActor
class HomeViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    @Published var dailyMotivation: String = ""
    
    func getDailyMotivation() {
        //  TODO
    }
}
