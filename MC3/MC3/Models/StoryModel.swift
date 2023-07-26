//
//  StoryModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import CloudKit

struct StoryModel {
    var id: CKRecord.ID?
    let keywords: [String]
    var rating: Int64 = 0
    let introduction, problem, resolution: [String]
    var introductionSound, problemSound, resolutionSound: [Data]?
}
