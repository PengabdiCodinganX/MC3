//
//  UserRepository.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation

class UserRepository: UserDataSource {
    var dataSource: UserDataSource
    
    func saveUser(user: UserModel) throws {
        return try dataSource.saveUser(user: user)
    }
    
    func getUser(userIdentifier: String) throws -> UserModel {
        return try dataSource.getUser(userIdentifier: userIdentifier)
    }
    
    func getAllUsers() throws -> [UserModel] {
        return try dataSource.getAllUsers()
    }
    
    
}
