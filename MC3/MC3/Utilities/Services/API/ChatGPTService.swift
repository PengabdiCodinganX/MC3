//
//  ChatGPTService.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import Foundation

struct ChatGPTService{
    private let apiManager: APIManager = APIManager()
    
    private let baseURL = URL(string: "https://api.openai.com/v1/completions")!
    private let maxTokens = 500
    private let temperature = 0.3
    
    private var apiKey: String = ""
    
    init() async throws {
        apiKey = try await apiManager.fetchAPIKey(apiType: .chatGPT)
    }
    
    private func fetchChatGptApi(prompt: String) async throws -> (Data, URLResponse){
        //create a new urlRequest passing the url
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["model": "text-davinci-003",
                                   "prompt": prompt,
                                   "max_tokens": self.maxTokens,
                                   "temperature": self.temperature]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        //runs the request passing the encoded JSON file
        let (data, response) = try await URLSession.shared.data(for: request)
        return (data,response)
    }
    
    func fetchMotivatinStoryFromProblem(problem: String) async throws -> Result<StoryModel, Error> {
        let prompt = """
       \(problem)
       
       From the text above, write a story about a famous person who relates to text above so that I will be more motivated. That have title,  problem_category and story in object: Introduction, Problem, Resolution. Each structure has one paragraphs in JSON format
       """
        
        let (data, _)  = try await fetchChatGptApi(prompt: prompt)
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let choices = json["choices"] as? [[String: Any]],
           let text = choices.first?["text"] as? String {
            let decoder = JSONDecoder()
            if let completedData = text.data(using: .utf8) {
                
                print("completed Data: ", text)
                let featureData = try decoder.decode(StoryModel.self, from: completedData)
                print("Feature Data: ", featureData)
                return .success(featureData)
            } else {
                let error = NSError(domain: "StoryModel Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                print(error)
                return .failure(error)
            }
        }
        
        let error = NSError(domain: "StoryModel Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
        return .failure(error)
    }
}
