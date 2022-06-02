//
//  Constants.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

struct Constants {
    struct TransactionsApi {
        static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
        static let url = "https://bank-statement-bff.herokuapp.com"
    }

    struct UserDefaultsConstants {
        static let isBalanceHidden = "isBalanceHidden"
    }
}
