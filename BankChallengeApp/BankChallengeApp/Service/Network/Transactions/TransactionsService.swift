//
//  TransactionsService.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

protocol TransactionsServiceProtocol {
    func fetchBalance(_ completion: @escaping(Result<Balance, HTTPRequestError>) -> Void)
    func fetchTransactions(limit: Int,
                        offset: Int,
                        _ completion: @escaping(Result<TransactionsApiResponse, HTTPRequestError>) -> Void)
    func fetchTransactionsDetails(with id: String,
                               _ completion: @escaping(Result<Transaction, HTTPRequestError>) -> Void)
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

    func fetchTransactions(limit: Int,
                        offset: Int,
                        _ completion: @escaping(Result<TransactionsApiResponse, HTTPRequestError>) -> Void) {
        let statementRequest = TransactionsRequest(limit: limit, offset: offset)

        networkClient.performRequest(with: statementRequest) { result in
            switch result {
            case .success(let data):
                let statementResponse = self.decodeJson(data: data, type: TransactionsApiResponse.self)
                guard let statementResponse = statementResponse else {
                    return completion(.failure(.couldNotParseResponse))
                }
                completion(.success(statementResponse))

            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }

    func fetchTransactionsDetails(with id: String,
                               _ completion: @escaping(Result<Transaction, HTTPRequestError>) -> Void) {
        let statementDetailsRequest = TransactionDetailsRequest(id: id)

        networkClient.performRequest(with: statementDetailsRequest) { result in
            switch result {
            case .success(let data):
                let response = self.decodeJson(data: data, type: Transaction.self)
                guard let response = response else {
                    return completion(.failure(.couldNotParseResponse))
                }
                completion(.success(response))

            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }

    private func decodeJson<T: Decodable>(data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try? decoder.decode(T.self, from: data)
        return decodedData
    }
}
