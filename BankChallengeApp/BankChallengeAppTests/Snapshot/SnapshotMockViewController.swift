//
//  SnapshotMockViewController.swift
//  BankChallengeAppTests
//
//  Created by Matheus Lenke on 02/06/22.
//

import UIKit

final class SnapshotMockViewController: UIViewController {
    
    func configureView(child: UIView) {
        view.addSubview(child)
        
        view.backgroundColor = .white

        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            child.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            child.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}
