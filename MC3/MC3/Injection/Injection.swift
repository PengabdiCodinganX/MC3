//
//  Injection.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import Foundation

struct Injec {
    func user() -> UserUseCase {
        let repo = UserRepositoryImpl(dataSource: UserCoreDataImpl())
        return UserUseCaseImpl(repository: repo)
    }
}
