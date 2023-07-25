//
//  Path.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import Foundation
import SwiftUI

enum ViewPath: Hashable {
    case problem
    case breathing
    case story
    case storyRecap
    case storyRepeat
    case storyReflection
    case selfAffirmation
    case storyLog
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .problem:
                InputProblemView()
            case .breathing:
                EmptyView()
            case .story:
                ValidateFeelingView()
            case .storyRecap:
                StoryRecapView()
            case .storyRepeat:
                EmptyView()
            case .storyReflection:
                EmptyView()
            case .selfAffirmation:
                SelfAffirmationView()
            case .storyLog:
                EmptyView()
            }
        }
}
