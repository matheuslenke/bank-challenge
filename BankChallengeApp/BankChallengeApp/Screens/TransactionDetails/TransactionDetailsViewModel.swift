//
//  DetailsViewModel.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 01/06/22.
//

import Foundation

protocol TransactionViewModelProtocol: AnyObject {
    func fetchDetailsWithSuccess()
    func errorToFetchDetails(_ error: String)
}

class TransactionDetailsViewModel {
    
    // MARK: - Variables
    
    private var transactionsService: TransactionsServiceProtocol
    public var delegate: TransactionViewModelProtocol?

    let transactionId: String
    public var transaction: Transaction?
    
    // MARK: - Initialization

    init(transactionsService: TransactionsServiceProtocol, transactionId: String) {
        self.transactionsService = transactionsService
        self.transactionId = transactionId
    }
    
    // MARK: - Functions

    func getTransaction() {
        transactionsService.fetchTransactionsDetails(with: transactionId) { result in
            switch result {
            case .success(let transaction):
                self.transaction = transaction
                self.delegate?.fetchDetailsWithSuccess()

            case .failure(let error):
                self.delegate?.errorToFetchDetails(error.localizedDescription)
            }
        }
    }
}
