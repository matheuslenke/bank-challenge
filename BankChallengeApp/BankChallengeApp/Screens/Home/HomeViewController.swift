//
//  ViewController.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Variables

    private let homeView = HomeView()

    private let cellSize = CGFloat(110)

    // MARK: - Life Cycle

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        let service = TransactionsService(networkClient: NetworkClient())
//        service.fetchBalance { result in
//            switch result {
//            case .success(let balance):
//                print(balance)
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }

        service.fetchStatement { result in
            switch result {
            case .success(let statement):
                print(statement)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Functions

    private func setup() {
        view.backgroundColor = .white
        title = "Extrato"

        setupHomeView()
    }

    private func setupHomeView() {
        homeView.delegateTableView(delegate: self, dataSource: self)
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellSize
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier)
                as? TransactionTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }

}
