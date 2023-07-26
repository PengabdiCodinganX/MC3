//
//  StoryModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation
import CloudKit

struct StoryModel: Codable{
    var id: CKRecord.ID?
    let keywords: [String]
    let story: StoryDetail
    let rating: Int64
    
    enum CodingKeys: String, CodingKey {
        case keywords
        case story
        case rating
    }
}

// MARK: - Story
struct StoryDetail: Codable {
    let introduction, problem, resolution: String
}

