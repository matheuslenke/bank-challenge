//
//  HomeViewModel.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func fetchBalanceWithSuccess()
    func errorToFetchBalance(_ error: String)
    func fetchTransactionsWithSuccess(with newIndexPathsToReload: [IndexPath]?)
    func errorToFetchTransactions(_ error: String)
}

class HomeViewModel {
    
    // MARK: - Instance Properties

    private let service: TransactionsServiceProtocol

    public var delegate: HomeViewModelProtocol?
    public var balance: Balance?
    public var transactions: [Transaction] = []
    private var isFetchInProgress = false

    weak var coordinator: HomeCoordinator?

    var isBalanceHidden: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.UserDefaultsConstants.isBalanceHidden)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsConstants.isBalanceHidden)
        }
    }
    // Defines how many transactions per request
    private var transactionsLimit = 10
    // Defines the offset of the transactions request pagination
    private var transactionsOffset = 0
    // Defines the current count of transactions
    public var currentCount: Int {
        return transactions.count
    }

    // MARK: - Initializers

    init(service: TransactionsServiceProtocol) {
        self.service = service
    }

    // MARK: - Helpers

    func getBalance() {
        service.fetchBalance { (result: Result<Balance, HTTPRequestError>) in
            switch result {
            case .success(let balance):
                self.balance = balance
                self.delegate?.fetchBalanceWithSuccess()

            case .failure(let error):
                self.delegate?.errorToFetchBalance(error.localizedDescription)
            }
        }
    }

    func getTransactions() {
        guard !isFetchInProgress else {
          return
        }

        isFetchInProgress = true
        service.fetchTransactions(limit: transactionsLimit, offset: transactionsOffset) { result in
            switch result {
            case .success(let response):
                self.successTransactions(response: response)

            case .failure(let error):
                self.errorTransactions(error: error.localizedDescription)
            }
        }
    }

    private func successTransactions(response: TransactionsApiResponse) {
        isFetchInProgress = false
        self.transactionsOffset += 1
        self.transactions.append(contentsOf: response.items)
        if self.transactionsOffset > 1 {
            let indexPathsToReload = self.calculateIndexPathsToReload(from: response.items)
            self.delegate?.fetchTransactionsWithSuccess(with: indexPathsToReload)
        } else {
            self.delegate?.fetchTransactionsWithSuccess(with: .none)
        }
    }

    private func errorTransactions(error: String) {
        self.delegate?.errorToFetchTransactions(error)
    }

    private func calculateIndexPathsToReload(from newTransactions: [Transaction]) -> [IndexPath] {
        let startIndex = transactions.count - newTransactions.count
        let endIndex = startIndex + newTransactions.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

    // MARK: - Navigation methods

    func goToTransactionDetails(transactionIndex: Int) {
        let transaction = self.transactions[transactionIndex]
        coordinator?.transactionDetails(transaction: transaction)
    }

    // MARK: - Button actions
    
    func toggleBalanceHidden() {
        self.isBalanceHidden = !self.isBalanceHidden
    }
}
