//
//  AuthViewModel.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 13/07/23.
//

import Foundation
import CoreData
import NaturalLanguage

@MainActor
class StoryViewModel: ObservableObject {
    private let storyCloudKitService: StoryCloudKitService = StoryCloudKitService()
    private var elevenLabsAPIService: ElevenLabsAPIService?
    private var chatCPTService: ChatGPTService?
    private let nlpService: NLPService = NLPService()
    
    @Published var stageScene: [StageScene] = []
    @Published var storyType: StoryType = .loading
    
    func initializeService() async throws {
        chatCPTService = try await ChatGPTService()
        elevenLabsAPIService = try await ElevenLabsAPIService()
    }
    
    func getKeywordByText(text: String) -> [String] {
        return nlpService.generateSummary(for: text)
    }
    
    func getStageScenes(story: StoryModel) -> [StageScene] {
        return [
            StageScene(name: "a-scene-1", text: story.introduction, soundList: story.introductionSound),
            StageScene(name: "a-scene-2", textColor: .white, text: story.problem, soundList: story.problemSound),
            StageScene(name: "a-scene-3", text: story.resolution, soundList: story.resolutionSound)
        ]
    }
    
    func getStory(userProblem: String) async throws -> StoryModel? {
        setLoading()
        
        print("[getStory][userProblem]", userProblem)
        let keywords = getKeywordByText(text: userProblem)
        print("[getStory][keywords]", keywords)
        
        let result = await storyCloudKitService.getStoryByKeywords(keywords: keywords)
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            print("[getStoryByKeyword][failure]", failure)
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
            
            return try await storyCloudKitService.saveStory(story: story)
        case .failure(let failure):
            print("[getStoryByChatGPT][failure]", failure)
            return nil
        case .none:
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
    
    func setLoading() {
        setStoryType(storyType: .loading)
    }
    
    func setScene() {
        setStoryType(storyType: .scene)
    }
    
    private func setStoryType(storyType: StoryType) {
        self.storyType = storyType
    }
    
//    private let viewContext = PersistenceController.shared.viewContext
//    @Published var storyFeedback: StoryFeedbackModel?
//    @Published var storyFeedbacks: [StoryFeedbackModel] = []
//
//    func saveStoryFeedback(storyFeedbackModel: StoryFeedbackModel, userModel: UserModel) {
//        let storyFeedback = StoryFeedback(context: viewContext)
//        storyFeedback.id = UUID()
//        storyFeedback.concern = storyFeedbackModel.concern
//        storyFeedback.rating = storyFeedbackModel.rating ?? 0
//        storyFeedback.feedback = storyFeedbackModel.feedback
//
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", userModel.id?.uuidString ?? "")
//
//        do {
//            let fetchedUsers = try viewContext.fetch(fetchRequest)
//            let user: User
//
//            if let fetchedUser = fetchedUsers.first {
//                // User already exists, use the existing one.
//                user = fetchedUser
//            } else {
//                // User doesn't exist, create a new one.
//                user = User(context: viewContext)
//                user.id = userModel.id
//                user.name = userModel.name
//            }
//
//            storyFeedback.user = user
//
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//
//    func getAllStoryFeedbacks() {
//        let fetchRequest: NSFetchRequest<StoryFeedback> = StoryFeedback.fetchRequest()
//
//        do {
//            let fetchedStoryFeedbacks = try viewContext.fetch(fetchRequest)
//            self.storyFeedbacks = fetchedStoryFeedbacks.map({ storyFeedback in
//                let user = UserModel(id: storyFeedback.user?.id, name: storyFeedback.user?.name)
//
//                return StoryFeedbackModel(
//                    id: storyFeedback.id,
//                    concern: storyFeedback.concern,
//                    rating: storyFeedback.rating,
//                    feedback: storyFeedback.feedback,
//                    user: user
//                )
//            })
//        } catch {
//            print("Error fetching users: \(error)")
//        }
//    }
//
//    func getAllStoryFeedbacksByUser(userModel: UserModel) {
//        let fetchRequestUser: NSFetchRequest<User> = User.fetchRequest()
//        fetchRequestUser.predicate = NSPredicate(format: "id == %@", userModel.id?.uuidString ?? "")
//
//        var user: User
//
//        do {
//            let fetchedUsers = try viewContext.fetch(fetchRequestUser)
//
//            if let fetchedUser = fetchedUsers.first {
//                // User already exists, use the existing one.
//                user = fetchedUser
//
//                let fetchRequest: NSFetchRequest<StoryFeedback> = StoryFeedback.fetchRequest()
//                fetchRequest.predicate = NSPredicate(format: "user == %@", user)
//
//                do {
//                    let fetchedStoryFeedbacks = try viewContext.fetch(fetchRequest)
//                    self.storyFeedbacks = fetchedStoryFeedbacks.map({ storyFeedback in
//                        let user = UserModel(id: storyFeedback.user?.id, name: storyFeedback.user?.name)
//
//                        return StoryFeedbackModel(
//                            id: storyFeedback.id,
//                            concern: storyFeedback.concern,
//                            rating: storyFeedback.rating,
//                            feedback: storyFeedback.feedback,
//                            user: user
//                        )
//                    })
//                } catch {
//                    print("Error fetching users: \(error)")
//                }
//            } else {
//                print("test")
//            }
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//
//    func deleteFeedback(storyFeedbackModel: StoryFeedbackModel) {
//        let fetchRequest: NSFetchRequest<StoryFeedback> = StoryFeedback.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", storyFeedbackModel.id?.uuidString ?? "")
//
//        do {
//            let storyFeedbacks = try viewContext.fetch(fetchRequest)
//            if let storyFeedback = storyFeedbacks.first {
//                viewContext.delete(storyFeedback)
//                try viewContext.save()
//            }
//        } catch {
//            print("Error deleting user: \(error)")
//        }
//    }
//
////    @Published var user: UserModel?
////    @Published var users: [UserModel] = []
////
////    func saveUser(userModel: UserModel) {
////        let user = User(context: viewContext)
////        user.id = UUID()
////        user.name = userModel.name
////
////        do {
////            try viewContext.save()
////        } catch {
////            let nsError = error as NSError
////            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
////        }
////    }
////
////    func deleteUser(userModel: UserModel) {
////        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
////        fetchRequest.predicate = NSPredicate(format: "id == %@", userModel.id?.uuidString ?? "")
////
////        do {
////            let users = try viewContext.fetch(fetchRequest)
////            if let user = users.first {
////                viewContext.delete(user)
////                try viewContext.save()
////            }
////        } catch {
////            print("Error deleting user: \(error)")
////        }
////    }
////
////    func getAllUsers() {
////        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
////
////        do {
////            let fetchedUsers = try viewContext.fetch(fetchRequest)
////            self.users = fetchedUsers.map({ user in
////                UserModel(id: user.id ?? UUID(), name: user.name ?? "")
////            })
////        } catch {
////            print("Error fetching users: \(error)")
////        }
////    }
}
