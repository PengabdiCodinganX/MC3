//
//  UserCoreDataService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 22/07/23.
//

//import Foundation
//
//class UserCoreDataService {
//    private let coreDataManager: CoreDataManager = CoreDataManager()
//    
//    func getAllUsers() -> Result<[UserModel], Error> {
//        let request = User.fetchRequest()
//        
//        do {
//            let data = try coreDataManager.viewContext.fetch(request).map({ data in
//                UserModel(
//                    id: data.id!,
//                    userIdentifier: data.userIdentifier,
//                    email: data.email,
//                    name: data.name
//                )
//            })
//            
//            return .success(data)
//        } catch {
//            return .failure(error)
//        }
//    }
//    
//    func getUser(userIdentifier: String) -> Result<UserModel, Error> {
//        let request = User.fetchRequest()
//        request.predicate = NSPredicate(format: "userIdentifier == %@", userIdentifier)
//        
//        do {
//            guard let data = try coreDataManager.viewContext.fetch(request).first else {
//                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
//            }
//            
//            let user = UserModel(
//                id: data.id,
//                userIdentifier: data.userIdentifier,
//                email: data.email,
//                name: data.name
//            )
//            
//            return .success(user)
//        } catch {
//            return .failure(error)
//        }
//    }
//    
//    func saveUser(user: UserModel) -> Result<UserModel, Error> {
//        let data = User(context: coreDataManager.viewContext)
//        data.id = user.id
//        data.userIdentifier = user.userIdentifier
//        data.email = user.email
//        data.name = user.name
//        
//        coreDataManager.saveContext()
//        
//        return .success(user)
//    }
//    
//    func updateUser(user: UserModel) -> Result<UserModel, Error> {
//        guard let userIdentifier = user.userIdentifier else {
//            return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
//        }
//        
//        let request = User.fetchRequest()
//        request.predicate = NSPredicate(format: "userIdentifier == %@", userIdentifier)
//        
//        do {
//            guard let data = try coreDataManager.viewContext.fetch(request).first else {
//                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
//            }
//            
//            data.email = user.email
//            data.name = user.name
//            
//            coreDataManager.saveContext()
//            
//            return .success(user)
//        } catch {
//            return .failure(error)
//        }
//    }
//}
