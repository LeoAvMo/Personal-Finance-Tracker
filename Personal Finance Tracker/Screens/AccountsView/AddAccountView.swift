//
//  AddAccountView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI
import SwiftData

struct AddAccountView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var currencies: [Currency]
    
    @State private var name: String = ""
    @State private var balance: Double?
    @State private var color: Color = .green
    @State private var accountType: AccountType = .cash
    @State private var currency: Currency?
    @State private var maxCredit: Double?
    
    @State private var alertItem: TrackerAlertItem?
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Name", text: $name)
                    .autocapitalization(.words)
                    
                
                Picker(selection: $currency, label: Text("Currency")) {
                    ForEach(currencies){currency in
                        Text(currency.code + currency.flag).tag(currency)
                    }
                }
                
                HStack{
                    Text("Balance")
                    Spacer()
                    TextField("$", value: $balance, format: .currency(code: currency?.code ?? ""))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                
                Picker(selection: $accountType, label: Text("Account type")){
                    ForEach(AccountType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                
                if accountType == .credit {
                    withAnimation {
                        HStack{
                            Text("Credit")
                            Spacer()
                            TextField("$", value: $maxCredit, format: .currency(code: currency?.code ?? "USD"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                        }
                    }
                }
                ColorPicker("Account Color", selection: $color)
            }
            .onAppear {
                currency = currencies.first
            }
            .navigationTitle(Text("Add Account"))
            .toolbar{
                Button("Create Account",systemImage: "checkmark", action: addAccount)
            }
        }
    }
    
    // TODO: Add alerts and checks for null cases.
    private func addAccount() {
        
        switch accountType {
            case .cash:
                maxCredit = nil
            case .debit:
                maxCredit = nil
            case .credit:
                maxCredit = maxCredit
        }
        
        if name.isEmpty {
            
            return
        }
        
        withAnimation {
            let account = Account(name: name, balance: balance ?? 0, colorHex: color.toHex() ?? "#FFFFFF", type: accountType, maxCredit: maxCredit ?? 0, currency: currency ?? Currency())
            modelContext.insert(account)
            dismiss()
        }
    }
}

#Preview {
    AddAccountView()
        .modelContainer(for: [Account.self, Currency.self], inMemory: true)
}
