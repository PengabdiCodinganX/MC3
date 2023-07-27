//
//  StoryIntroductionViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 26/07/23.
//

import Foundation
import NaturalLanguage
import CloudKit

@MainActor
class StoryIntroductionViewModel: ObservableObject {
    private let storyCloudKitService: StoryCloudKitService = StoryCloudKitService()
    private let historyCloudKitService: HistoryCloudKitService = HistoryCloudKitService()
    
    private var elevenLabsAPIService: ElevenLabsAPIService?
    private var chatCPTService: ChatGPTService?
    private let nlpService: NLPService = NLPService()
    
    func initializeService() async throws {
        chatCPTService = try await ChatGPTService()
        elevenLabsAPIService = try await ElevenLabsAPIService()
    }
    
    func getKeywordByText(text: String) -> [String] {
        return nlpService.generateSummary(for: text)
    }
    
    func getStory(userProblem: String) async throws -> StoryModel? {
        print("[getStory][userProblem]", userProblem)
        let keywords = getKeywordByText(text: userProblem)
        print("[getStory][keywords]", keywords)
        
        let result = await storyCloudKitService.getStoryByKeywords(keywords: keywords)
        
        switch result {
        case .success(let success):
            print("[getStory][success]", success)
            return success
        case .failure(let failure):
            print("[getStoryByKeyword][failure]", failure)
            try await self.initializeService()
            
            guard let data = try await getStoryByChatGPT(keywords: keywords, userProblem: userProblem) else {
                return nil
            }
            
            return data
        }
    }
    
    func tokenizeSentences(text: String) -> [String] {
        let tokenizer = NLTokenizer(unit: .sentence)
        tokenizer.string = text
        return tokenizer.tokens(for: text.startIndex..<text.endIndex).map {String(text[$0])}
    }
    
    func getStoryByChatGPT(keywords: [String], userProblem: String) async throws -> StoryModel? {
        try await self.initializeService()
        
        let result = await chatCPTService?.fetchMotivatinStoryFromProblem(problem: userProblem)
        print("[getStoryByChatGPT][keywords]", keywords)
        print("[getStoryByChatGPT][userProblem]", userProblem)
        print("[getStoryByChatGPT][result]", result as Any)
        
        switch result {
        case .success(let data):
            var story = StoryModel(
                keywords: keywords,
                introduction: tokenizeSentences(text: data.introduction),
                problem: tokenizeSentences(text: data.problem),
                resolution: tokenizeSentences(text: data.resolution)
            )
            
            let introductionSound = try await getSoundByTextList(textList: story.introduction)
            let problemSound = try await getSoundByTextList(textList: story.problem)
            let resolutionSound = try await getSoundByTextList(textList: story.resolution)
            
            story.introductionSound = introductionSound
            story.problemSound = problemSound
            story.resolutionSound = resolutionSound
            
            let result = try await saveStory(story: story)
            
            return result
        case .failure(let failure):
            print("[getStoryByChatGPT][failure]", failure)
            return nil
        case .none:
            return nil
        }
    }
    
    func saveStory(story: StoryModel) async throws -> StoryModel {
        return try await storyCloudKitService.saveStory(story: story)
    }
    
    func updateHistory(history: HistoryModel, story: StoryModel) async throws -> HistoryModel? {
        print("[updateHistory][history]", history)
        print("[updateHistory][story]", story)
        
        guard let storyRecordID = story.id else {
            print("user record not found.")
            // handle case when user id is nil
            return nil
        }
        
        let storyReference = CKRecord.Reference(recordID: storyRecordID, action: .none)

        var historyUpdate = history
        historyUpdate.story = storyReference
        
        let result = await historyCloudKitService.updateHistory(history: historyUpdate)
        
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            print("failure", failure)
            return nil
        }
    }
    
    func getSoundByTextList(textList: [String]) async throws -> [Data] {
        var data: [Data] = []
        
        for text in textList {
            guard let result = try await elevenLabsAPIService?.fetchTextToSpeech(text: text) else { return data
            }
            data.append(result)
        }
        
        return data
    }
}
