//
//  AccountsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI
import SwiftData

// TODO: Add toolbar to create accounts and currencies

struct AccountsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Account.name) var accounts: [Account]
    @Query(sort: \Currency.name) var currencies: [Currency]
    @State private var selectedCurrency: Currency = Currency()
    
    private var formattedBalance: String {
        var total: Double = 0.0
        for account in accounts {
            if account.balance > 0 {
                total += account.balance
            }
        }
        return String(format: "$%.2f %@", total, selectedCurrency.code)
    }
    
    var body: some View {
        
        NavigationStack {
            Form{
                
                Section (header: Text("Total balance")) {
                    Picker(selection: $selectedCurrency, label: Text("Picker")) {
                        ForEach(currencies) { currency in
                            Text(currency.code + currency.flag).tag(currency)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack{
                        Spacer()
                        Text(formattedBalance)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    
                }
                

                Section(header: Text("Cash")) {
                    ForEach(accounts) { account in
                        if account.type == .cash {
                            AccountCapsuleView(account: account)
                        }
                    }
                }
                
                Section(header: Text("Cards")) {
                    ForEach(accounts){ account in
                        if account.type != .cash {
                            AccountCapsuleView(account: account)
                        }
                    }
                }
            }
            .onAppear{
                if let selectedCurrency = currencies.first {
                    self.selectedCurrency = selectedCurrency
                }
            }
            .navigationTitle("Accounts")
            .toolbar {
                Menu ("Add", systemImage: "plus"){
                    Button("Add Account",systemImage: "creditcard.fill", action: addAccount)
                    Button("Add Currency",systemImage: "eurosign", action: addCurrency)
                }
                
            }
        }
    }
    
    private func addAccount() {
        withAnimation {
            let account = Account()
            modelContext.insert(account)
        }
    }
    
    private func addCurrency() {
        withAnimation {
            let currency = Currency()
            modelContext.insert(currency)
        }
    }
}

#Preview {
    AccountsView()
        .modelContainer(for: [Account.self, Currency.self], inMemory: true)
}
