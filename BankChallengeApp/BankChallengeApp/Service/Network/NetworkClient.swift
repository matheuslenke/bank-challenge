//
//  NetworkClient.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

typealias Completion = (Result<Data, HTTPRequestError>) -> Void

protocol NetworkClientProtocol {
    func performRequest(with request: Request, completion: @escaping Completion)
}

class NetworkClient: NetworkClientProtocol {

    func performRequest(with request: Request, completion: @escaping Completion) {

        guard let url = URL(string: request.baseURL)?.appendingPathComponent(request.path) else {
            return completion(.failure(.couldNotFormURL))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            if let error = error {
                completion(.failure(.failure(error.localizedDescription)))
                return
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode < 200 || response.statusCode > 300 {
                    completion(.failure(.failure("Error code: \(response.statusCode)")))
                    return
                }
            }

            guard let data = data else {
                completion(.failure(.couldNotParseResponse))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }
}
