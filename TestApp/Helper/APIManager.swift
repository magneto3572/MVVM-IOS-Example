//
//  APIManager.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 23/12/22.
//

import Foundation

// Singleton Design Pattern
// final - inheritance nahi hoga theek hai final ho gya

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}
// Like to banta hai bhaio
// Please like the video - Please, request, mentioned not - daya 😂
// typealias Handler = (Result<[Product], DataError>) -> Void

typealias Handler<T> = (Result<T, DataError>) -> Void

final class APIManager {

    static let shared = APIManager()
    private init() {}

    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL)) // I forgot to mention this in the video
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue

        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }

        request.allHTTPHeaderFields = type.headers

        // Background task
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            // JSONDecoder() - Data ka Model(Array) mai convert karega
            do {
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }

        }.resume()
    }


    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}

