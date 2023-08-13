//
//  StoryFeedback.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation
import CloudKit

struct HistoryModel: Identifiable, Hashable {
    var id: CKRecord.ID?
    var problem: String?
    var reflection: String?
    var user: CKRecord.Reference?
    var story: CKRecord.Reference?
    var rating: CKRecord.Reference?
    var createdTimestamp: Date?
}
