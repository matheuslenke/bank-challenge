//
//  UIViewController+Extensions.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 01/06/22.
//

import UIKit

extension UIViewController {
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alertController, animated: true)
    }
}
