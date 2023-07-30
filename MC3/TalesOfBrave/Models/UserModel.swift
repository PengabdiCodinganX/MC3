//
//  UserModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation
import CloudKit

struct UserModel: Identifiable {
    var id: CKRecord.ID?
    var userIdentifier: String?
    var email: String?
    var name: String?
    var dev: Int64?
}
