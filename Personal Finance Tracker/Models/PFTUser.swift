//
//  PFTUser.swift
//  FinanceTrackerTest
//
//  Created by Leo A.Molina on 11/09/25.
//

import SwiftUI
import SwiftData

@Model
class PFTUser {
    var username: String
    var balance: Double
    
    @Relationship(deleteRule: .cascade, inverse: \Transaction.user)
    var transactions = [Transaction]()
    
    @Relationship(deleteRule: .cascade, inverse: \Account.user)
    var accounts = [Account]()
    
    @Relationship(deleteRule: .cascade, inverse: \Currency.user)
    var currencies = [Currency]()
    
    @Relationship(deleteRule: .cascade, inverse: \Category.user)
    var categories = [Category]()
    
    init(username: String = "User", balance: Double = 0) {
        self.username = username
        self.balance = balance
    }
}
