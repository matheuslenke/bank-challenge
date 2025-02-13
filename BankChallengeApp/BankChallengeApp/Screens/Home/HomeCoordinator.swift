//
//  HomeCoordinator.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 01/06/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    // MARK: - Instance properties

    private(set) var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController
    
    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Helpers

    func start() {
        let homeViewController = HomeViewController()
        let transactionsService = TransactionsService(networkClient: NetworkClient())
        let homeViewModel = HomeViewModel(service: transactionsService)
        homeViewModel.coordinator = self
        homeViewController.viewModel = homeViewModel

        navigationController.setViewControllers([homeViewController], animated: true)
    }

    func transactionDetails(transaction: Transaction) {
        let transactionDetailsCoordinator = TransactionDetailsCoordinator(
            navigationController: self.navigationController,
            transaction: transaction)

        childCoordinators.append(transactionDetailsCoordinator)
        transactionDetailsCoordinator.start()
    }
}
