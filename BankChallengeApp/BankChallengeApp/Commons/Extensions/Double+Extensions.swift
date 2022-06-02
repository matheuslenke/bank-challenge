//
//  Double+Extensions.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

extension Double {
    func formatPriceBRL() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.alwaysShowsDecimalSeparator = true
        formatter.currencySymbol = "R$"
        formatter.decimalSeparator = ","
        return formatter.string(from: NSNumber(value: self)) ?? "Error formatting price"
    }
}
