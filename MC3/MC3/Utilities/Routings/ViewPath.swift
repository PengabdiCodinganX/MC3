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
    case breathing(HistoryModel)
    case storyIntro(HistoryModel)
    case story(HistoryModel, StoryModel)
    case storyRecap(HistoryModel, StoryModel)
    case storyRepeat
    case storyReflection(HistoryModel)
    case storyReflectionDetail(HistoryModel)
    case storyReflectionComplete
    case selfAffirmation
    case storyLog
    case developer
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .problem:
                StoryProblemView()
            case .breathing(let history):
                BreathingView(history: history)
            case .storyIntro(let history):
                StoryIntroductionView(history: history)
            case .story(let history, let story):
                StoryView(history: history, story: story)
            case .storyRecap(let history, let story):
                StoryRecapView(history: history, story: story)
            case .storyRepeat:
                EmptyView()
            case .storyReflection(let history):
                ReflectionInputView(history: history)
            case .storyReflectionDetail(let history):
                ReflectionDetailView(history: history)
            case .storyReflectionComplete:
                ReflectionCompleteView()
            case .selfAffirmation:
                SelfAffirmationView()
            case .storyLog:
                EmptyView()
            case .developer:
                DeveloperView()
            }
        }
}
