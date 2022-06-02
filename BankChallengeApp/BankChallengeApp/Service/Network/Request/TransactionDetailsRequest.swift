//
//  StatementDetailsRequest.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

struct TransactionDetailsRequest: Request {

    let id: String

    var baseURL: String {
        return Constants.TransactionsApi.url
    }

    var path: String {
        return "myStatement/detail/\(id)"
    }

    var method: HTTPMethod {
        .get
    }

    var parameters: [String: Any]? {
        return nil
    }

    var headers: [String: String]? {
        return ["token": Constants.TransactionsApi.token]
    }
}
