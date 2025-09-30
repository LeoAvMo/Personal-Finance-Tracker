//
//  TransferFundsView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 27/09/25.
//

import SwiftUI
import SwiftData

// TODO: Add taxes in case of different currencies.
struct TransferFundsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Account.name) var accounts: [Account]
    @Query(sort: \Currency.name) var currencies: [Currency]
    
    @State private var sourceAccount: Account?
    @State private var destinationAccount: Account?
    @State private var amount: Double = 0
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
                    
                    AccountDescriptionListView(account: sourceAccount ?? Account(), transactionAmount: amount, transactionType: TransactionType.expense, isSelected: false)
                    
                    Picker(selection: $destinationAccount, label: Text("Destination")) {
                        ForEach(accounts) { account in
                            Text(account.name).tag(account)
                        }
                    }
                    
                    AccountDescriptionListView(account: destinationAccount ?? Account(), transactionAmount: amount, transactionType: TransactionType.income, isSelected: false)
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
                
                if !currenciesAreDifferent {
                    Section(header: Text("Summary")) {
                        
                            HStack{
                                Spacer()
                                // Make conversion amount be calculated when this section apepars (Selecting amount)
                                
                                VStack{
                                    
                                    Text("-\(amount, format: .currency(code: sourceAccount?.currency.code ?? ""))")
                                        .foregroundStyle(.red)
                                        .font(.caption)
                                    
                                    Text("\((sourceAccount?.balance ?? amount) - amount, format: .currency(code: sourceAccount?.currency.code ?? ""))")
                                        .foregroundStyle(sourceAccount?.color ?? .primary)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(sourceAccount?.name ?? "No account")")
                                        .foregroundStyle(.secondary)
                                }
                        
                                Image(systemName: "chevron.right.2")
                                
                                VStack {
                                    Text("+\(amount, format: .currency(code: destinationAccount?.currency.code ?? ""))")
                                        .foregroundStyle(.green)
                                        .font(.caption)
                                    
                                    Text("\((destinationAccount?.balance ?? 0) + amount, format: .currency(code: destinationAccount?.currency.code ?? ""))")
                                        .foregroundStyle(destinationAccount?.color ?? .primary)                                .foregroundStyle(destinationAccount?.color ?? .primary)
                                        .fontWeight(.semibold)
                                        Text("\(destinationAccount?.name ?? "No account")")
                                            .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                        
                        
                    }
                }
                
                
                
            }
            .navigationTitle(Text("Transfer Funds"))
            .onAppear {
                sourceAccount = accounts.first
                destinationAccount = accounts.last
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Transfer", systemImage: "checkmark", action: transfer)
                }
            }
        }
    }
    
    private func transfer() {
        
        if currenciesAreDifferent {
            // set alertItem
            showAlert = true
            return
        }
        
        if sourceAccount == destinationAccount {
            showAlert = true
            return
        }
        
        if sourceAccount == nil || destinationAccount == nil {
            showAlert = true
            return
        }
        
        if sourceAccount?.balance ?? 0 < amount {
            showAlert = true
            return
        }
        
        if amount == 0 || amount.isNaN || amount.isInfinite {
            showAlert = true
            return
        }
        
        sourceAccount!.balance -= amount
        destinationAccount!.balance += amount
        dismiss()
    }
}

#Preview {
    TransferFundsView()
}
