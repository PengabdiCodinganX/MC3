//
//  StoryFeedback.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation

struct StoryFeedbackModel: Identifiable {
    var id: UUID?
    var concern: String?
    var rating: Int16?
    var feedback: String?
    var user: UserModel?
}
