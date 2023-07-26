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
    case breathing(String)
    case storyIntro(String)
    case story(String)
    case storyRecap
    case storyRepeat
    case storyReflection
    case selfAffirmation
    case storyLog
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .problem:
                StoryProblemView()
            case .breathing(let userProblem):
                BreathingView(userProblem: userProblem)
            case .storyIntro(let userProblem):
                IntroductionToStoryView(userProblem: userProblem)
            case .story(let userProblem):
                StoryView(userProblem: userProblem)
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
