//
//  AccountsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI
import SwiftData

// TODO: Create screen to force user to create ONE currency and ONE account.
// TODO: Make add account and add currency view return to this view once it is created.
// TODO: Present another view if there are no currencies or accounts
// TODO: Do not duplicate currency when creating an account

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
                    Picker(selection: $selectedCurrency, label: Text("Currency:")) {
                        ForEach(currencies) { currency in
                            Text(currency.code + " " + currency.flag).tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    
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
                            AccountCapsuleView(account: account, isSelected: false)
                        }
                    }
                }
                
                
                Section(header: Text("Cards")) {
                    ForEach(accounts){ account in
                        if account.type != .cash {
                            AccountCapsuleView(account: account, isSelected: false)
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
                    NavigationLink{
                        AddAccountView()
                    } label: {
                        Button("Add Account", systemImage: "creditcard"){ }
                    }
                    NavigationLink{
                        AddCurrencyView()
                    } label: {
                        Button("Add Currency", systemImage: "eurosign"){ }
                    }
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
