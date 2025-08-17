//
//  Account.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 17/08/25.
//

import SwiftUI

struct Account: Identifiable {
    var id: Int     //Change to UUID later
    var name: String
    var balance: Double
    var color: Color
    
    init(id: Int, name: String, balance: Double, color: Color) {
        self.id = id
        self.name = name
        self.balance = balance
        self.color = color
    }
}

struct MockData {
    let mockAccounts: [Account] = [Account(id: 1, name: "Banamex", balance: 550.20, color: Color(red: 0, green: 0.5, blue: 0.9)),
                                   Account(id: 2, name: "Santander", balance: 250.20, color: Color(red: 0.95, green: 0.2, blue: 0.2))]
}
