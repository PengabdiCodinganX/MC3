//
//  DeveloperViewModel.swift
//  TalesOfBrave
//
//  Created by Muhammad Adha Fajri Jonison on 30/07/23.
//

import Foundation
import NaturalLanguage

class DeveloperViewModel: ObservableObject {
    private var elevenLabsAPIService: ElevenLabsAPIService?
    private var storyCloudKitService: StoryCloudKitService = StoryCloudKitService()
    
    func tokenizeSentences(text: String) -> [String] {
        let tokenizer = NLTokenizer(unit: .sentence)
        tokenizer.string = text
        return tokenizer.tokens(for: text.startIndex..<text.endIndex).map {String(text[$0])}
    }
    
    func saveStory(introduction: String, problem: String, resolution: String) async throws -> StoryModel {
        var story = StoryModel(
            keywords: [],
            introduction: tokenizeSentences(text: introduction),
            problem: tokenizeSentences(text: problem),
            resolution: tokenizeSentences(text: resolution)
        )
        
        let introductionSound = try await getSoundByTextList(textList: story.introduction)
        let problemSound = try await getSoundByTextList(textList: story.problem)
        let resolutionSound = try await getSoundByTextList(textList: story.resolution)
        
        story.introductionSound = introductionSound
        story.problemSound = problemSound
        story.resolutionSound = resolutionSound
        
        return try await storyCloudKitService.saveStory(story: story)
    }
    
    func getSoundByTextList(textList: [String]) async throws -> [Data] {
        elevenLabsAPIService = try await ElevenLabsAPIService()
        
        return try await withThrowingTaskGroup(of: Data.self) { group in
            for text in textList {
                try await Task.sleep(nanoseconds: 1 * 1_000_000_000) // nanoseconds
                
                group.addTask {
                    try await self.fetchWithRetry(service: self.elevenLabsAPIService!, text: text)
                }
            }

            var data = [Data]()
            for try await result in group {
                data.append(result)
            }

            return data
        }
    }

    private func fetchWithRetry(service: ElevenLabsAPIService, text: String, retryCount: Int = 3) async throws -> Data {
        do {
            return try await service.fetchTextToSpeech(text: text)
        } catch {
            print("[fetchWithRetry][catch]", error)
            if retryCount > 0 {
                return try await fetchWithRetry(service: service, text: text, retryCount: retryCount - 1)
            } else {
                throw error
            }
        }
    }
}
