//
//  ReflectionViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import CloudKit

class ReflectionInputViewModel: ObservableObject {
    private let appStorageService: AppStorageService = AppStorageService()
    private var historyCloudKitService: HistoryCloudKitService = HistoryCloudKitService()
    
    func updateHistory(history: HistoryModel, reflection: String) async -> HistoryModel? {
        var historyUpdate = history
        historyUpdate.reflection = reflection
        
        let result = await historyCloudKitService.updateHistory(history: historyUpdate)
        
        switch result {
        case .success(let success):
            print("[ReflectionInputViewModel][updateHistory][success]", success)
            return success
        case .failure(let failure):
            print("[updateHistory][failure]", failure)
            return nil
        }
    }
}
