//
//  AccountsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI
import SwiftData

// TODO: Add edit account, edit currency and add empty views when there is no cash or cards.
// TODO: Make it possible so you can transfer money between accounts

struct AccountsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Account.name) var accounts: [Account]
    @Query(sort: \Currency.name) var currencies: [Currency]
    
    @State private var selectedCurrency: Currency = Currency()
    
    @State private var showAlert: Bool = false
    
    private var formattedBalance: String {
        var total: Double = 0.0
        for account in accounts {
            if account.currency == selectedCurrency {
                total += account.balance
            } else {
                total += account.balance * account.currency.value / selectedCurrency.value
            }
        }
        return String(format: "$%.2f %@", total, selectedCurrency.code)
    }
    
    var body: some View {
        NavigationStack {
            if !accounts.isEmpty || !currencies.isEmpty {
                AccountCurrencySetupView()
            } else {
                Form{
                    
                    totalBalanceView
                    
                    
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
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("No Accounts or Currencies"))
                }
                .toolbar {
                    NavigationLink(){
                        // Add a way so the user cannot enter this view unless they have 2 accounts.
                        TransferFundsView()
                    } label: {
                        Button("Transfer Funds", systemImage: "arrow.left.arrow.right"){ }
                    }
                    
                    Menu ("Add", systemImage: "plus"){
                        NavigationLink{
                            AddAccountView()
                        } label: {
                            Button("Add Account", systemImage: "creditcard"){ }
                        }
                        NavigationLink {
                            AddCurrencyView()
                        } label: {
                            Button("Add Currency", systemImage: "eurosign"){ }
                        }
                    }
                    
                }
            }
        }
    }
    
    private var totalBalanceView: some View {
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
    }
}

#Preview {
    AccountsView()
        .modelContainer(for: [Account.self, Currency.self], inMemory: true)
}
