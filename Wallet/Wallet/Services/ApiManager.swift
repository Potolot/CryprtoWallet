//
//  Network.swift
//  Wallet
//
//  Created by Вадим Воляс on 24.01.2023.
//

import Foundation
import UIKit

class ApiManager {
    
    static let shared = ApiManager()

    enum ApiError: LocalizedError {
        case invalidUrl
        case networkError
        case decoderError
        case unknownError
        var errorDescription: String? {
            switch self {
            case .invalidUrl:
                return "invalidUrl"
            case .networkError:
                return "networkError"
            case .decoderError:
                return "decoderError"
            case .unknownError:
                return "unknownError"
            }
        }
    }
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func makeRequest(for url: String, complition: @escaping (Result<Crypto, ApiError>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.failure(.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                complition(.failure(.networkError))
            } else if let data = data {
                do {
                    let result = try self.jsonDecoder.decode(Crypto.self, from: data)
                    complition(.success(result))
                }
                catch {
                    complition(.failure(.decoderError))
                }
            } else {
                complition(.failure(.unknownError))
            }
        }
        task.resume()
    }
}


