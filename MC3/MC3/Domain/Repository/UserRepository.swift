//
//  UserRepository.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation

protocol UserRepository {
    func getUser(userIdentifier: String) throws -> UserModel
    func getAllUsers() throws -> [UserModel]
    func saveUser(user: UserModel) throws -> UserModel
}
