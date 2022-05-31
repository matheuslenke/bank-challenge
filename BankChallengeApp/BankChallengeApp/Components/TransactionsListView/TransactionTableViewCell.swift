//
//  TransactionTableViewCell.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    // MARK: - Instance properties

    static let identifier = "TransactionTableViewCell"
    var isPixTransaction = false

    // MARK: - Views

    private let lineContainerView: LineWithCircleView = {
        let view = LineWithCircleView(circleColor: Colors.primaryGreen,
                                      circleBorderColor: UIColor.white,
                                      lineColor: Colors.secondaryTitleColor,
                                      circleRadius: CGFloat(5))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let transactionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Transferência recebida"
        label.textColor = Colors.primaryTitleColor
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pixLabel: UILabel = {
        let label = UILabel()
        label.text = "Pix"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.backgroundColor = Colors.primaryGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameAndDateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "David Bond"
        label.textColor = Colors.secondaryTitleColor
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10/10"
        label.textAlignment = .center
        label.textColor = Colors.secondaryTitleColor
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "R$2,00"
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with model: String) {

    }

}

extension TransactionTableViewCell: ViewConfiguration {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            lineContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lineContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineContainerView.widthAnchor.constraint(equalToConstant: 50),
            lineContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            infoStackView.leadingAnchor.constraint(equalTo: lineContainerView.trailingAnchor),
            infoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),

            dateLabel.widthAnchor.constraint(equalToConstant: 50),

            pixLabel.widthAnchor.constraint(equalToConstant: 50),
            pixLabel.heightAnchor.constraint(equalToConstant: 20)

        ])
    }

    func buildViewHierarchy() {
        contentView.addSubview(lineContainerView)
        contentView.addSubview(infoStackView)

        infoStackView.addArrangedSubview(titleStackView)
        infoStackView.addArrangedSubview(nameAndDateStackView)
        infoStackView.addArrangedSubview(priceLabel)

        titleStackView.addArrangedSubview(transactionTitleLabel)
        titleStackView.addArrangedSubview(pixLabel)

        nameAndDateStackView.addArrangedSubview(nameLabel)
        nameAndDateStackView.addArrangedSubview(dateLabel)
    }
}
