//
//  StoryModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation

struct StoryModel: Codable{
    var id: UUID = UUID()
    let title, problemCategory: String
    let story: StoryDetail
    
    enum CodingKeys: String, CodingKey {
        case title
        case problemCategory = "problem_category"
        case story
    }
}

// MARK: - Story
struct StoryDetail: Codable {
    let introduction, problem, resolution: String
}

