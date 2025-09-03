//
//  MockData.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 28/08/25.
//

import SwiftUI

struct MockData {
    
    static let mockCategory: Category = Category(id: UUID(), name: "Expenses", color: .green, iconName: "dollarsign")
    
    static let mockCurrencyMXN: Currency = Currency(name: "Mexican Peso",
                                                    code: "MXN",
                                                    flag: "🇲🇽",
                                                    value: 1.0)
    
    static let mockCurrencyUSD: Currency = Currency(name: "US Dollar",
                                                    code: "USD",
                                                    flag: "🇺🇸",
                                                    value: 18.65)
    
    static let mockAccount: Account = Account(name: "Mexican Peso", balance: 15000, color: .green, currency: MockData.mockCurrencyMXN, isCash: true)
    
    static let mockAccounts: [Account] = [
                                        Account(id: UUID(),
                                                  name: "Mexican Pesos",
                                                  balance: 1500,
                                                  color: Color(red: 0, green: 0.8, blue: 0.9),
                                                  currency: MockData.mockCurrencyMXN,
                                                  isCash: true),
                                        Account(id: UUID(),
                                                  name: "Banamex",
                                                  balance: 550.20,
                                                  color: Color(red: 0, green: 0.5, blue: 0.9),
                                                  currency: MockData.mockCurrencyMXN,
                                                  isCash: false),
                                         Account(id: UUID(),
                                                 name: "Santander",
                                                 balance: 250.20,
                                                 color: Color(red: 0.95, green: 0.2, blue: 0.2),
                                                 currency: MockData.mockCurrencyUSD,
                                                 isCash: false)
                                          ]
    
    static let mockCurrencies: [Currency] = [
                                            Currency(name: "Mexican Peso",
                                                     code: "MXN", flag: "🇲🇽",
                                                     value: 1.0),
                                             Currency(name: "US Dollar",
                                                      code: "USD",
                                                      flag: "🇺🇸",
                                                      value: 18.65),
                                             Currency(name: "Euro",
                                                      code: "EUR",
                                                      flag: "🇪🇺",
                                                      value: 21.79)
                                            ]
    
    static let mockCategories: [Category] = [
                                             Category(id: UUID(),
                                                      name: "Transportation",
                                                      color: .gray,
                                                      iconName: "car.fill"),
                                             Category(id: UUID(),
                                                      name: "Food",
                                                      color: .orange,
                                                      iconName: "fork.knife"),
                                             Category(id: UUID(),
                                                      name: "Coffeee",
                                                      color: .brown,
                                                      iconName: "mug.fill"),
                                             Category(id: UUID(),
                                                      name: "Expenses",
                                                      color: .green,
                                                      iconName: "dollarsign")
                                            ]
}
