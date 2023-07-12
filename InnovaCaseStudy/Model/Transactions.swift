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
    let id = UUID().uuidString
    let date: String?
    let price: Price

    enum TransactionType: String, Codable {
        case income = "Income"
        case expense = "Expense"
    }
}
// MARK: - Price

struct Price: Codable {
    let value: Double
    let currency: CurrencyType?
    
    enum CurrencyType: String, Codable {
        case EUR = "€"
        case USD = "$"
        case TRY = "₺"
    }
}

extension Price {
    func calculatePrice() -> String {
        let currency = currency
        let price = String(value)
        return price + " " + (currency?.rawValue ?? "₺")
    }
}

