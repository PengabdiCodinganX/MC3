//
//  UserRepository.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation
import CoreData

class UserCoreDataImpl: UserDataSource {
    private let viewContext = PersistenceController.shared.viewContext

    func getAllUsers() throws -> [UserModel]{
        let request = User.fetchRequest()
        return try viewContext.fetch(request).map({ data in
            UserModel(
                id: data.id!,
                userIdentifier: data.userIdentifier,
                email: data.email,
                name: data.name
            )
        })
    }
    
    func getUser(userIdentifier: String) throws -> UserModel {
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "userIdentifier == %@", userIdentifier)
        
        guard let data = try viewContext.fetch(request).first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        
        return UserModel(
            id: data.id,
            userIdentifier: data.userIdentifier,
            email: data.email,
            name: data.name
        )
    }
    
    func saveUser(user: UserModel) throws -> UserModel {
        let data = User(context: viewContext)
        data.id = user.id
        data.userIdentifier = user.userIdentifier
        data.email = user.email
        data.name = user.name
        
        saveContext()
        
        return user
    }
    
    func updateUser(user: UserModel) throws -> UserModel {
        guard let userIdentifier = user.userIdentifier else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"])
        }
        
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "userIdentifier == %@", userIdentifier)
        
        guard let data = try viewContext.fetch(request).first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        
        data.email = user.email
        data.name = user.name
        
        saveContext()
        
        return user
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do{
                try viewContext.save()
            }catch{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
