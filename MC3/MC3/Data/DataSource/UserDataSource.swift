//
//  DataSource.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation

protocol UserDataSource {
    func saveUser(user: UserModel) throws -> ()
    func getUser(userIdentifier: String) throws -> UserModel
    func getAllUsers() throws -> [UserModel]
}
