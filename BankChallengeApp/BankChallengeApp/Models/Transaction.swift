//
//  Transaction.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

// MARK: - API Response
struct TransactionsApiResponse: Codable {
    let items: [Transaction]

//    enum CodingKeys: String, CodingKey {
//        case transactions = "items"
//    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let tType: TransactionType
    let amount: Double
    let to: String?
    let id: String
    let itemDescription: String?
    let createdAt: Date?
    let bankName: String?
    let from: String?
    let authentication: String?

    enum CodingKeys: String, CodingKey {
        case tType, amount, to, id
        case itemDescription = "description"
        case createdAt, bankName, from, authentication
    }
}

// MARK: - Transaction Type
enum TransactionType: String, Codable {
    case bankslipcashin = "BANKSLIPCASHIN"
    case pixcashin = "PIXCASHIN"
    case pixcashout = "PIXCASHOUT"
    case transferin = "TRANSFERIN"
    case transferout = "TRANSFEROUT"

    func returnTransactionName() -> String {
        switch self {
        case .bankslipcashin:
            return "Depósito via boleto"

        case .pixcashin:
            return "Transferência PIX realizada"

        case .pixcashout:
            return "Transferência PIX recebida"

        case .transferin:
            return "Transferência recebida"

        case .transferout:
            return "Transferência realizada"
        }
    }
}
