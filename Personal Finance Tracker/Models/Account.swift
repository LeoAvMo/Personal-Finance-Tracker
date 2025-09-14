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
class Account: Hashable, Equatable {
    var name: String
    var balance: Double
    var colorHex: String
    var color: Color { Color(colorHex) }
    var type: AccountType
    var currency: Currency
    var maxCredit: Double?   // only used if AccountType is .credit
    
    
    init(name: String = "", balance: Double = 0, colorHex: String = "#000000", type: AccountType = .cash, maxCredit: Double? = nil, currency: Currency = Currency()) {
        self.name = name
        self.balance = balance
        self.colorHex = colorHex
        self.type = type
        self.maxCredit = maxCredit
        self.currency = currency
    }
}
