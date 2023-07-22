//
//  APIService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 22/07/23.
//

import Foundation
import CloudKit

@MainActor
class ElevenLabsAPIService {
    private let cloudKitService: CloudKitService
    private let apiManager: APIManager
    
    private let baseURL = "https://api.elevenlabs.io/v1/"
    private var apiKey: String = ""
    
    init() async throws {
        cloudKitService = CloudKitService()
        apiManager = APIManager()
        apiKey = try await fetchAPIKey()
    }
    
    private func fetchAPIKey() async throws -> String {
        print("[ElevenLabsAPIService][fetchAPIKey]")
        let result = try await cloudKitService.fetchApiKeyData(apiType: .elevenLabs)
        print("[ElevenLabsAPIService][fetchAPIKey][result]", result)
        
        return result
    }
    
    /// /v1/text-to-speech/{voice_id}
    func fetchTextToSpeech(text: String, voiceId: String) async throws {
        guard let url = URL(string: baseURL + "text-to-speech/\(voiceId)") else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Base URL not found"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = [
            "text": text,
            "model_id": "eleven_monolingual_v1",
            "voice_settings": [
                "stability": 0.5,
                "similarity_boost": 0.5
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        apiManager.fetchData(request: <#T##URLRequest#>, completion: <#T##(Result<Data, Error>) -> Void#>)
        
        APIService.shared.fetchData(request: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
