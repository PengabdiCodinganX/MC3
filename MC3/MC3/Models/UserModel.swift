//
//  UserModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation

struct UserModel: Identifiable {
    var id: UUID?
    var userIdentifier: String?
    var email: String?
    var name: String?
}
