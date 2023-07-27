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
    case story(String, StoryModel)
    case storyRecap(String, StoryModel)
    case storyRepeat
    case storyReflection
    case storyReflectionDetail(String)
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
                StoryIntroductionView(userProblem: userProblem)
            case .story(let userProblem, let story):
                StoryView(userProblem: userProblem, story: story)
            case .storyRecap(let userProblem, let story):
                StoryRecapView(userProblem: userProblem, story: story)
            case .storyRepeat:
                EmptyView()
            case .storyReflection:
                ReflectionInputView()
            case .storyReflectionDetail(let userReflection):
                ReflectionDetailView(reflection: userReflection)
            case .selfAffirmation:
                SelfAffirmationView()
            case .storyLog:
                EmptyView()
            }
        }
}
