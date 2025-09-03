//
//  Transaction.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 02/09/25.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    var id: UUID = UUID()
    var transactionLabel: String
    var transactionCurrency: Currency
    var transactionAmount: Double
    var transactionDate: Date
    var transactionCategory: Category
    var transactionAccount: Account
}
