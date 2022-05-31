//
//  HTTPRequestError.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

enum HTTPRequestError: Error {
    case couldNotFormURL
    case couldNotParseResponse
    case failure(String)
    case unknown(String)
}
