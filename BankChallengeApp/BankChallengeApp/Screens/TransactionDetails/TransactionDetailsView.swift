//
//  DetailsView.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 01/06/22.
//

import UIKit

protocol TransactionDetailsViewProtocol: AnyObject {
    func actionShareButton(with image: UIImage)
}

class TransactionDetailsView: UIView {
    // MARK: - Variables

    private weak var delegate: TransactionDetailsViewProtocol?

    // MARK: Views
    
    private let sharingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let receiptTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comprovante"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.secondaryTitleColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let typeView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        view.setup(title: "Tipo de movimentação", value: "Transferência enviada")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let valueView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        view.setup(title: "Valor", value: "Valor da movimentação")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let fromView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        view.setup(title: "Recebedor", value: "Nome do recebedor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bankNameView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        view.setup(title: "Tipo de movimentação", value: "Transferência enviada")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dateView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        view.setup(title: "Tipo de movimentação", value: "Transferência enviada")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let authenticationView: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        view.setup(title: "Tipo de movimentação", value: "Transferência enviada")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Compartilhar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = Colors.primaryGreen
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loadingView: UIActivityIndicatorView = {
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
        setupSelectors()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    public func delegate(delegate: TransactionDetailsViewProtocol) {
        self.delegate = delegate
    }

    func setupSelectors() {
        shareButton.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
    }

    func setup(with transaction: Transaction) {
        DispatchQueue.main.async {
            self.loadingView.stopAnimating()
            self.loadingView.removeFromSuperview()
            self.contentStackView.isHidden = false

            self.typeView.setup(title: "Tipo de movimentação", value: transaction.tType.returnTransactionName())
            self.valueView.setup(title: "Valor", value: transaction.amount.formatPriceBRL())
            self.fromView.setup(title: "Recebedor", value: transaction.from ?? "Sem recebedor")
            let dateFormatter = DateFormatter.fullDate
            self.bankNameView.setup(title: "Instituição bancária", value: transaction.bankName ?? "Sem nome")
            self.dateView.setup(title: "Data/Hora", value: dateFormatter.string(from: transaction.createdAt ?? Date()))
        }
    }

    // MARK: - Selectors

    @objc func sharePressed() {
        let image = sharingView.asImage()

        delegate?.actionShareButton(with: image)
    }
}

extension TransactionDetailsView: ViewConfiguration {

    func configureViews() {
        self.backgroundColor = Colors.backgroundColor
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            sharingView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            sharingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sharingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sharingView.bottomAnchor.constraint(equalTo: shareButton.topAnchor),

            receiptTitleLabel.topAnchor.constraint(equalTo: sharingView.topAnchor, constant: 15),
            receiptTitleLabel.centerXAnchor.constraint(equalTo: sharingView.centerXAnchor),

            lineView.topAnchor.constraint(equalTo: receiptTitleLabel.bottomAnchor, constant: 20),
            lineView.leadingAnchor.constraint(equalTo: sharingView.leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: sharingView.trailingAnchor, constant: -10),
            lineView.heightAnchor.constraint(equalToConstant: 1),

            contentStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: sharingView.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: sharingView.trailingAnchor, constant: -15),

            shareButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            shareButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func buildViewHierarchy() {
        self.addSubview(sharingView)
        sharingView.addSubview(receiptTitleLabel)
        sharingView.addSubview(lineView)

        sharingView.addSubview(contentStackView)

        contentStackView.addArrangedSubview(typeView)
        contentStackView.addArrangedSubview(valueView)
        contentStackView.addArrangedSubview(fromView)
        contentStackView.addArrangedSubview(bankNameView)
        contentStackView.addArrangedSubview(dateView)
        contentStackView.addArrangedSubview(authenticationView)

        self.addSubview(shareButton)
    }

    func setupLoadingView() {
        contentStackView.isHidden = true

        self.addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        loadingView.startAnimating()
    }
}
