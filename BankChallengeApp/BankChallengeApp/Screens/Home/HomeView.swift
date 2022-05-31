//
//  HomeView.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Views

    private let balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()

    private let balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Seu saldo"
        label.textColor = Colors.primaryTitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let toggleBalanceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = Colors.primaryGreen
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 1.345,00"
        label.textColor = Colors.primaryGreen
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let transactionsListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Suas movimentações"
        label.textColor = Colors.primaryTitleColor
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    public func delegateTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }

    public func reloadTableView() {
        self.tableView.reloadData()
    }
}

// MARK: - ViewConfiguration

extension HomeView: ViewConfiguration {

    func setupConstraints() {
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            balanceView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            balanceView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            balanceView.heightAnchor.constraint(equalToConstant: 100),

            verticalStackView.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 16),
            verticalStackView.centerYAnchor.constraint(equalTo: balanceView.centerYAnchor),

            toggleBalanceButton.heightAnchor.constraint(equalToConstant: 16),

            transactionsListLabel.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 25),
            transactionsListLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                           constant: 16),

            tableView.topAnchor.constraint(equalTo: transactionsListLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    func buildViewHierarchy() {
        self.addSubview(balanceView)
        balanceView.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(balanceLabel)

        horizontalStackView.addArrangedSubview(balanceTitleLabel)
        horizontalStackView.addArrangedSubview(toggleBalanceButton)

        self.addSubview(transactionsListLabel)
        self.addSubview(tableView)
    }
}
