//
//  HomeViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let appStorageService: AppStorageService
    
    @Published var dailyMotivation: String = ""
    
    init() {
        appStorageService = AppStorageService()
    }
    
    func getDailyMotivation() {
        //  TODO
    }
}
