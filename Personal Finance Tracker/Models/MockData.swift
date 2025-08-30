//
//  MockData.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 28/08/25.
//

import SwiftUI

struct MockData {
    
    let mockAccounts: [Account] = [Account(id: 1, name: "Banamex", balance: 550.20, color: Color(red: 0, green: 0.5, blue: 0.9)),
                                   Account(id: 2, name: "Santander", balance: 250.20, color: Color(red: 0.95, green: 0.2, blue: 0.2))]
    
    let mockCurrencies: [Currency] = [Currency(name: "Mexican Peso", code: "MXN", flag: "🇲🇽", value: 1.0),
                                      Currency(name: "US Dollar", code: "USD", flag: "🇺🇸", value: 18.65),
                                      Currency(name: "Euro", code: "EUR", flag: "🇪🇺", value: 21.79)]
    
    let mockCategories: [Category] = [Category(id: UUID(), name: "Transportation", color: .gray, iconName: "car.fill"),
                                      Category(id: UUID(), name: "Food", color: .orange, iconName: "fork.knife"),
                                      Category(id: UUID(), name: "Coffeee", color: .brown, iconName: "mug.fill"),
                                      Category(id: UUID(), name: "Expenses", color: .green, iconName: "dollarsign")]
}

