//
//  APIManager.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 22/07/23.
//

import Foundation

class APIManager {
    private let cloudKitService: CloudKitService
    
    init() {
        cloudKitService = CloudKitService()
    }
    
    func fetchAPIKey(apiType: APIType) async throws -> String {
        print("[APIManager][fetchAPIKey]")
        let result = try await cloudKitService.fetchApiKeyData(apiType: apiType)
        print("[APIManager][fetchAPIKey][result]", result)
        
        return result
    }
    
    func fetchData(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        print("[APIManager][fetchData][response]", response)
        
        return data
    }
}
