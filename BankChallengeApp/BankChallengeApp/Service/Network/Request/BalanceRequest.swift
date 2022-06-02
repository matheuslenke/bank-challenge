//
//  BalanceRequest.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

struct BalanceRequest: Request {

    var baseURL: String {
        return Constants.TransactionsApi.url
    }

    var path: String {
        return "myBalance"
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
