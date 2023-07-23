//
//  UserViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 15/07/23.
//

import Foundation
import CoreData

class UserViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var user: UserModel?
    @Published var users: [UserModel] = []
    
    func setUser(user: UserModel) {
        self.user = user
    }
    
    func saveUser(userModel: UserModel) {
        let user = User(context: viewContext)
        user.id = UUID()
        user.name = userModel.name
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteUser(userModel: UserModel) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userModel.id?.uuidString ?? "")
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                viewContext.delete(user)
                try viewContext.save()
            }
        } catch {
            print("Error deleting user: \(error)")
        }
    }
    
    func getAllUsers() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            let fetchedUsers = try viewContext.fetch(fetchRequest)
            self.users = fetchedUsers.map({ user in
                
                UserModel(id: user.id ?? UUID(), name: user.name ?? "")
            })
        } catch {
            print("Error fetching users: \(error)")
        }
    }
}
