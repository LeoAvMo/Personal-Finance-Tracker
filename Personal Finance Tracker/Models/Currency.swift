//
//  Currency.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 28/08/25.
//

import SwiftUI
import SwiftData

@Model
class Currency {
    var name: String
    var code: String
    var flag: String
    var value: Double

    
    @Relationship(deleteRule: .nullify, inverse: \Account.currency)
    var accounts: [Account] = []

    @Relationship(deleteRule: .nullify, inverse: \Transaction.currency)
    var transactions: [Transaction] = []

    init(name: String, code: String, flag: String, value: Double) {
        self.name = name
        self.code = code
        self.flag = flag
        self.value = value
    }
}
