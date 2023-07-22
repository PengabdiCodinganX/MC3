//
//  APIManager.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 22/07/23.
//

import Foundation

class APIManager {
    func fetchData(request: URLRequest) async throws {
        let task = URLSession.shared.dataTask(with: request)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"])
                completion(.failure(error))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }
}
