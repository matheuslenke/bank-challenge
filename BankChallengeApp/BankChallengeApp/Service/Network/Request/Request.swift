//
//  Request.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

protocol Request {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Request {
    var parameters: [String: Any]? {
        nil
    }

    var headers: [String: String]?? {
        nil
    }
}
