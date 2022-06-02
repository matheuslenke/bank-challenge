//
//  DetailsViewController.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import UIKit

class TransactionDetailsViewController: UIViewController {
    
    private let detailsView = TransactionDetailsView()
    
    var viewModel: TransactionDetailsViewModel?

    // MARK: Life Cycle

    override func loadView() {
        self.view = detailsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        viewModel?.delegate = self
        viewModel?.getTransaction()

        setupHomeView()
    }

    func setupHomeView() {
        detailsView.delegate(delegate: self)
        detailsView.setupLoadingView()
    }
}

extension TransactionDetailsViewController: TransactionViewModelProtocol {
    func fetchDetailsWithSuccess() {
        guard let viewModel = viewModel, let transaction = viewModel.transaction else {
            return
        }
        detailsView.setup(with: transaction)
    }

    func errorToFetchDetails(_ error: String) {
        print(error)
    }
}

extension TransactionDetailsViewController: TransactionDetailsViewProtocol {
    func actionShareButton(with image: UIImage) {
        let textToShare = """
        Bank App
        Comprovante
        """
        let activityViewController = UIActivityViewController(activityItems: [textToShare, image],
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)
    }
}
