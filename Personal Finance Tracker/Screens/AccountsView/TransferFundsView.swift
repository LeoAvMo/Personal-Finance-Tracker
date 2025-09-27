//
//  TransferFundsView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 27/09/25.
//

import SwiftUI
import SwiftData

struct TransferFundsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Account.name) var accounts: [Account]
    @Query(sort: \Currency.name) var currencies: [Currency]
    
    @State private var sourceAccount: Account?
    @State private var destinationAccount: Account?
    @State private var amount: Double?
    @State private var conversionAmount: Double?
    
    @State private var showAlert: Bool = false
    @State private var alertItem: TrackerAlertItem?
    
    
    var currenciesAreDifferent: Bool {
        return sourceAccount?.currency != destinationAccount?.currency
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Source & Destination")) {
                    Picker(selection: $sourceAccount, label: Text("Source")) {
                        ForEach(accounts) { account in
                            Text(account.name).tag(account)
                        }
                    }
                    .onSubmit {
                        if currenciesAreDifferent {
                            
                            // conversionAmount = account.balance * account.currency.value / selectedCurrency.value
                        }
                    }
                    
                    AccountDescriptionListView(account: sourceAccount ?? Account(), transactionAmount: amount ?? 0, transactionType: TransactionType.expense, isSelected: false)
                    
                    Picker(selection: $destinationAccount, label: Text("Destination")) {
                        ForEach(accounts) { account in
                            Text(account.name).tag(account)
                        }
                    }
                    
                    AccountDescriptionListView(account: destinationAccount ?? Account(), transactionAmount: amount ?? 0, transactionType: TransactionType.income, isSelected: false)
                }
                
                
                Section(header: Text("Amount")) {
                    VStack(alignment: .leading){
                        HStack{
                            Text("Amount")
                            TextField("$", value: $amount, format: .currency(code: destinationAccount?.currency.code ?? ""))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                        }
                        .padding(.bottom, 4)
                        
                        Text("Currency is selected depending on the destination account's curency.")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                    }
                }
                
                if currenciesAreDifferent {
                    Section(header: Text("Conversion")) {
                        HStack{
                            // Make conversion amount be calculated when this section apepars (Selecting amount)
                            TextField("$", value: $conversionAmount, format: .currency(code: sourceAccount?.currency.code ?? ""))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                                
                            Image(systemName: "chevron.right.2")
                            
                            TextField("$", value: $amount, format: .currency(code: destinationAccount?.currency.code ?? ""))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                        }
                    }
                }
                
            }
            .navigationTitle(Text("Transfer Funds"))
            .onAppear {
                sourceAccount = accounts.first
                destinationAccount = accounts.last
            }
        }
    }
}

#Preview {
    TransferFundsView()
}
