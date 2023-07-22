//
//  UserUseCase.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation

protocol UserUseCase {
    func saveUser(user: UserModel) -> Result<UserModel, Error>
    func getUser(userIdentifier: String) -> Result<UserModel, Error>
    func getAllUsers() -> Result<[UserModel], Error>
}

struct UserUseCaseImpl: UserUseCase {
    var repository: UserRepository
    
    func getUser(userIdentifier: String) -> Result<UserModel, Error> {
        do {
            let data = try repository.getUser(userIdentifier: userIdentifier)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getAllUsers() -> Result<[UserModel], Error> {
        do {
            let data = try repository.getAllUsers()
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func saveUser(user: UserModel) -> Result<UserModel, Error> {
        do {
            let data = try repository.saveUser(user: user)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
