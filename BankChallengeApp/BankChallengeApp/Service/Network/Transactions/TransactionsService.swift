//
//  TransactionsService.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

protocol TransactionsServiceProtocol {
    
}

class TransactionsService: TransactionsServiceProtocol {
    let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {

        self.networkClient = networkClient
    }

    func fetchBalance(_ completion: @escaping(Result<Balance, HTTPRequestError>) -> Void) {
        let balanceRequest = BalanceRequest()

        networkClient.performRequest(with: balanceRequest) { result in
            switch result {
            case .success(let data):
                let balance = self.decodeJson(data: data, type: Balance.self)
                guard let balance = balance else {
                    return completion(.failure(.couldNotParseResponse))
                }
                completion(.success(balance))

            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }

    func fetchStatement(_ completion: @escaping(Result<StatementApiResponse, HTTPRequestError>) -> Void) {
        let statementRequest = StatementRequest(limit: 10, offset: 0)

        networkClient.performRequest(with: statementRequest) { result in
            switch result {
            case .success(let data):
                let statementResponse = self.decodeJson(data: data, type: StatementApiResponse.self)
                guard let statementResponse = statementResponse else {
                    return completion(.failure(.couldNotParseResponse))
                }
                completion(.success(statementResponse))

            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }

    private func decodeJson<T: Decodable>(data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try? decoder.decode(T.self, from: data)
        return decodedData
    }
}
