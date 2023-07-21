//
//  UserRepository.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation

struct UserRepositoryImpl: UserRepository {
    var dataSource: UserDataSource
    
    func getUser(userIdentifier: String) throws -> UserModel {
        return try dataSource.getUser(userIdentifier: userIdentifier)
    }
    
    func getAllUsers() throws -> [UserModel] {
        return try dataSource.getAllUsers()
    }
    
    func saveUser(user: UserModel) throws -> UserModel {
        return try dataSource.saveUser(user: user)
    }
}
