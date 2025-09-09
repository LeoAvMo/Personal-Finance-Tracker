//
//  Account.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 17/08/25.
//

import SwiftUI
import SwiftData

enum AccountType: String, Codable {
    case cash
    case debit
    case credit
}

@Model
class Account {
    var name: String
    var balance: Double
    var color: Color
    var type: AccountType
    var currency: Currency
    var maxCredit: Double?   // only used if AccountType is .credit

    @Relationship(deleteRule: .cascade, inverse: \Transaction.targetAccount)
    var transactions: [Transaction] = []

    init(name: String = "Account", balance: Double = 0, color: Color = .green, type: AccountType = .cash, maxCredit: Double? = nil, currency: Currency) {
        self.name = name
        self.balance = balance
        self.color = color
        self.type = type
        self.maxCredit = maxCredit
        self.currency = currency
    }
}
