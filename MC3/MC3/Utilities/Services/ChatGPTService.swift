//
//  ChatGPTService.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 23/07/23.
//

import Foundation

struct ChatGPTService{
    private let baseURL = URL(string: "https://api.openai.com/v1/completions")!
    private let maxTokens = 500
    private let temperature = 0.3
    
    private func fetchAuthorizationKey() -> String{
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let configDict = NSDictionary(contentsOfFile: path),
              let authorizationKey = configDict["AuthorizationKey"] as? String else {
            print("Failed to read AuthorizationKey from Config.plist")
            return ""
        }
        
        return authorizationKey
    }
    
    private func fetchChatGptApi(prompt: String) async throws -> (Data, URLResponse){
        let authorizationKey = fetchAuthorizationKey()
        //create a new urlRequest passing the url
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authorizationKey)", forHTTPHeaderField: "Authorization")
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
    
    func fetchMotivatinStoryFromProblem(problem: String) async throws -> Void{
        let prompt = """
       \(problem)
       
       From the text above, write a story about a famous person who relates to text above so that I will be more motivated. That have title,  problem_category and story in object: Introduction, Problem, Resolution. Each structure has one paragraphs in JSON format
       """
        
        do {
            let (data, _)  = try await fetchChatGptApi(prompt: prompt)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let text = choices.first?["text"] as? String {
                let decoder = JSONDecoder()
                if let completedData = text.data(using: .utf8) {
                    do {
                        print("completed Data: ", text)
                        let featureData = try decoder.decode(StoryModel.self, from: completedData)
                        print("Feature Data: ", featureData)
                    } catch {
                        print(error)
                        
                    }
                } else {
                    let error = NSError(domain: "StoryModel Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                    print(error)
                }
            }
        } catch {
            let error = NSError(domain: "StoryModel Failed", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to request to data"])
            print(error)
        }
    }
}
