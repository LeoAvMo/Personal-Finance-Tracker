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
    @Bindable var user: PFTUser
    @State private var selectedCurrency: Currency = Currency()
    
    private var formattedBalance: String {
        var total: Double = 0.0
        for account in user.accounts {
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
                        ForEach(user.currencies) { currency in
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
                    ForEach(user.accounts) { account in
                        if account.type == .cash {
                            AccountCapsuleView(account: account)
                        }
                    }
                }
                
                Section(header: Text("Cards")) {
                    ForEach(user.accounts){ account in
                        if account.type != .cash {
                            AccountCapsuleView(account: account)
                        }
                    }
                }
            }
            .onAppear{
                if let selectedCurrency = user.currencies.first {
                    self.selectedCurrency = selectedCurrency
                }
            }
            .navigationTitle("Accounts")
        }
    }
}

#Preview {
    AccountsView(user: PFTUser())
        .modelContainer(for: PFTUser.self, inMemory: true)
}
