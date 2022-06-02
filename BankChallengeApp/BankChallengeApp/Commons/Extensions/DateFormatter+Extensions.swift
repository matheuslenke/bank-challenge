//
//  Date+Extensions.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 31/05/22.
//

import Foundation

extension DateFormatter {
    static var dayAndMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }
    
    static var fullDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYY - hh:mm:ss"
        return formatter
    }
}
