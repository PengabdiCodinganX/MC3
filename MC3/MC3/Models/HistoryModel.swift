//
//  StoryFeedback.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation
import CloudKit

struct HistoryModel: Identifiable {
    var id: CKRecord.ID?
    var problem: String?
    var rating: Double?
    var feedback: String?
}
