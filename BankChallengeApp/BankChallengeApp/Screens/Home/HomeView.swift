//
//  HomeView.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func actionToggleEyeButton() -> Bool
}

class HomeView: UIView {
    // MARK: - Instance Properties
    
    private weak var delegate: HomeViewProtocol?

    // MARK: - Views

    private let balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    private lazy var toggleBalanceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = Colors.primaryGreen
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(toggleBalanceIsHidden), for: .touchUpInside)
        return button
    }()

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 00,00"
        label.textColor = Colors.primaryGreen
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private let balanceLoadingView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = Colors.primaryGreen
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    private let hiddenBalanceView: UIView = {
       let view = UIView()
        view.layer.borderColor = Colors.backgroundColor.cgColor
        view.backgroundColor = Colors.primaryGreen
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let transactionsListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Suas movimentações"
        label.textColor = Colors.primaryTitleColor
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let loadingTableView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.style = .medium
        activityView.color = Colors.primaryGreen
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    public func delegate(delegate: HomeViewProtocol) {
        self.delegate = delegate
    }

    public func delegateTableView(delegate: UITableViewDelegate,
                                  dataSource: UITableViewDataSource,
                                  prefetchDataSource: UITableViewDataSourcePrefetching) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
        self.tableView.prefetchDataSource = prefetchDataSource
    }

    public func reloadTableView() {
        DispatchQueue.main.async {
            self.loadingTableView.removeFromSuperview()
            self.tableView.reloadData()
        }
    }

    public func setupBalance(with balance: Balance, isHidden: Bool) {
        balanceLoadingView.stopAnimating()
        balanceLoadingView.removeFromSuperview()
        balanceLabel.text = balance.amount.formatPriceBRL()
        setupHiddenView(isHidden: isHidden)
    }
    
    // MARK: - Selectors

    @objc func toggleBalanceIsHidden(_ sender: UIButton) {
        guard let isBalanceHidden = delegate?.actionToggleEyeButton() else {
            return
        }
        if isBalanceHidden {
            toggleBalanceButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            balanceLabel.isHidden = true
        } else {
            toggleBalanceButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            balanceLabel.isHidden = false
        }
        setupHiddenView(isHidden: isBalanceHidden)
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

            horizontalStackView.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 20),
            horizontalStackView.topAnchor.constraint(equalTo: balanceView.topAnchor, constant: 15),

            balanceLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10),
            balanceLabel.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 10),
            balanceLabel.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 20),

            toggleBalanceButton.heightAnchor.constraint(equalToConstant: 16),

            transactionsListLabel.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 25),
            transactionsListLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                           constant: 16),

            tableView.topAnchor.constraint(equalTo: transactionsListLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func buildViewHierarchy() {
        self.addSubview(balanceView)

        balanceView.addSubview(horizontalStackView)
        balanceView.addSubview(balanceLabel)

        horizontalStackView.addArrangedSubview(balanceTitleLabel)
        horizontalStackView.addArrangedSubview(toggleBalanceButton)

        self.addSubview(transactionsListLabel)
        self.addSubview(tableView)
    }

    func setupHiddenView(isHidden: Bool) {
        if isHidden {
            balanceLabel.isHidden = true
            balanceView.addSubview(hiddenBalanceView)

            NSLayoutConstraint.activate([
                hiddenBalanceView.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: -15),
                hiddenBalanceView.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 20),
                hiddenBalanceView.widthAnchor.constraint(equalToConstant: 150),
                hiddenBalanceView.heightAnchor.constraint(equalToConstant: 10)
            ])
        } else {
            hiddenBalanceView.removeFromSuperview()
            balanceLabel.isHidden = false
        }
    }

    func setupLoadingView() {
        balanceLabel.isHidden = true
        self.balanceView.addSubview(balanceLoadingView)

        NSLayoutConstraint.activate([
            balanceLoadingView.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: -20),
            balanceLoadingView.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 50)
        ])
        balanceLoadingView.startAnimating()

        self.tableView.backgroundView = loadingTableView
        NSLayoutConstraint.activate([
            loadingTableView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            loadingTableView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
        loadingTableView.startAnimating()
    }
}
