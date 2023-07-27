//
//  StoryModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation
import CloudKit

struct ChatGPTStoryModel: Decodable {
    let introduction, problem, resolution: String
    
    enum CodingKeys: String, CodingKey {
        case introduction = "introduction"
        case problem = "problem"
        case resolution = "resolution"
        
        case capitalIntroduction = "Introduction"
        case capitalProblem = "Problem"
        case capitalResolution = "Resolution"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        introduction = try container.decodeIfPresent(String.self, forKey: .introduction) ??
                       container.decodeIfPresent(String.self, forKey: .capitalIntroduction) ??
                       ""
        
        problem = try container.decodeIfPresent(String.self, forKey: .problem) ??
                  container.decodeIfPresent(String.self, forKey: .capitalProblem) ??
                  ""
        
        resolution = try container.decodeIfPresent(String.self, forKey: .resolution) ??
                     container.decodeIfPresent(String.self, forKey: .capitalResolution) ??
                     ""
    }
}

