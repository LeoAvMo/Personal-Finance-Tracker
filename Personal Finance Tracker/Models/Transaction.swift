//
//  Transaction.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 02/09/25.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
    var label: String
    var amount: Double
    var date: Date
    var category: Category
    var targetAccount: Account
    var currency: Currency
    
    
    init(label: String = "", amount: Double = 0, date: Date = .now, category: Category = Category(), targetAccount: Account = Account(), currency: Currency = Currency()) {
        self.label = label
        self.amount = amount
        self.date = date
        self.category = category
        self.targetAccount = targetAccount
        self.currency = currency
    }
}
    
