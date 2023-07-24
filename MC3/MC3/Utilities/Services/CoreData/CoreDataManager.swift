//
//  CoreDataManager.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 23/07/23.
//

import Foundation

class CoreDataManager {
    let viewContext = PersistenceController.shared.viewContext
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
