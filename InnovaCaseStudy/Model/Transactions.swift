//
//  Transactions.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import Foundation

struct Transactions: Codable {
    let type: TransactionType?
    let name: String?
    let date: String?

    enum TransactionType: String, Codable {
        case income = "Income"
        case expense = "Expense"
    }
}

extension Transactions {
    struct Constants {
        static let dateFormat = "dd-MM-yyyy"
    }

    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        guard let date = date else {
            return nil
        }
        guard let transactionDate = dateFormatter.date(from: date) else {
            return nil
        }
        return dateFormatter.string(from: transactionDate)
    }
}
