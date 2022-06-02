//
//  ViewController.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Instance Properties

    var viewModel: HomeViewModel?

    private let homeView = HomeView()
    private let cellSize = CGFloat(110)

    // MARK: - Life Cycle

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        getBalance()
        getTransactions()
    }

    // MARK: - Helpers

    private func setup() {
        view.backgroundColor = .white
        title = "Extrato"

        viewModel?.delegate = self

        setupHomeView()
    }

    private func setupHomeView() {
        homeView.delegateTableView(delegate: self, dataSource: self, prefetchDataSource: self)
        homeView.delegate(delegate: self)
        homeView.setupLoadingView()
    }

    private func getBalance() {
        viewModel?.getBalance()
    }

    private func getTransactions() {
        viewModel?.getTransactions()
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellSize
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.goToTransactionDetails(transactionIndex: indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactions.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier)
                as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        if let transaction = viewModel?.transactions[indexPath.row] {
            cell.setup(with: transaction)
        }
        return cell
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension HomeViewController: UITableViewDataSourcePrefetching {

  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel?.getTransactions()
    }
  }
}

// MARK: - Infinite scroll methods

extension HomeViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (viewModel?.currentCount ?? 2) - 2
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = homeView.tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

// MARK: - HomeViewModelProtocol

extension HomeViewController: HomeViewModelProtocol {
    func fetchBalanceWithSuccess() {
        if let balance = viewModel?.balance {
            DispatchQueue.main.async {
                self.homeView.setupBalance(with: balance, isHidden: self.viewModel?.isBalanceHidden ?? false)
            }
        }
    }

    func errorToFetchBalance(_ error: String) {
        self.displayAlert(title: "Error", message: "Erro ao pegar dados do saldo")
    }

    func fetchTransactionsWithSuccess(with newIndexPathsToReload: [IndexPath]?) {
        self.homeView.reloadTableView()
    }

    func errorToFetchTransactions(_ error: String) {
        self.displayAlert(title: "Error", message: "Erro ao pegar dados das movimentações")
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewProtocol {
    func actionToggleEyeButton() -> Bool {
        self.viewModel?.toggleBalanceHidden()
        return viewModel?.isBalanceHidden ?? true
    }
}
