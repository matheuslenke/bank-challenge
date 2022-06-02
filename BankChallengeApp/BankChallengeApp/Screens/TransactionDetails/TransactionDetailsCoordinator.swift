//
//  DetailsCoordinator.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 01/06/22.
//

import UIKit

class TransactionDetailsCoordinator: Coordinator {
    
    // MARK: - Instance Properties
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let transaction: Transaction

    // MARK: - Initialization
    
    init(navigationController: UINavigationController, transaction: Transaction ) {
        self.transaction = transaction
        self.navigationController = navigationController
    }

    func start() {
        let detailsViewController = TransactionDetailsViewController()
        let transactionsService = TransactionsService(networkClient: NetworkClient())
        detailsViewController.viewModel = TransactionDetailsViewModel(transactionsService: transactionsService,
                                                                      transactionId: transaction.id)

        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
