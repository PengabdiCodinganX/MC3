//
//  APIManager.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 22/07/23.
//

import Foundation

class APIManager {
    func fetchData(request: URLRequest) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
}
