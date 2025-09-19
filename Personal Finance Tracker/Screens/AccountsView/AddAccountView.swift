//
//  AddAccountView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI
import SwiftData


enum AccountFields: Hashable{
    case name, currency, balance
}
// TODO: Create better navigation in the form for better UX

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
    
    @FocusState private var focusedField: AccountFields?
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Name", text: $name)
                    .autocapitalization(.words)
                    .focused($focusedField, equals: .name)
                    .onSubmit {
                        focusedField = .currency
                    }
                
                Picker(selection: $currency, label: Text("Currency")) {
                    ForEach(currencies){currency in
                        Text(currency.code + currency.flag).tag(currency)
                    }
                }
                .focused($focusedField, equals: .currency)
                .onSubmit {
                    focusedField = .balance
                }
                
                HStack{
                    Text("Balance")
                    Spacer()
                    TextField("$", value: $balance, format: .currency(code: currency?.code ?? ""))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .onSubmit {
                            focusedField = nil
                        }
                }
                
                Picker(selection: $accountType, label: Text("Account type")){
                    ForEach(AccountType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                .pickerStyle(.menu)
                
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
                                .onSubmit {
                                    focusedField = nil
                                }
                        }
                    }
                }
                ColorPicker("Account Color", selection: $color)
            }
            .onAppear {
                currency = currencies.first
            }
            .alert(isPresented: $showAlert) {
                Alert(title: alertItem!.alertTitle,
                      message: alertItem!.alertMessage,
                      dismissButton: alertItem!.alertDismissButton)
            }
            .navigationTitle(Text("Add Account"))
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Create Account",systemImage: "checkmark", action: addAccount)
                }
            }
        }
    }
    
    // TODO: Add alerts and checks for null cases.
    private func addAccount() {
        
        // Making color to hex string to save it
        let colorHex = color.toHex()
        
        if name.isEmpty {
            alertItem = TrackerAlertContext.accountHasNoName
            showAlert.toggle()
            return
        }
        
        if currency == nil {
            alertItem = TrackerAlertContext.invalidAccountCurrency
            showAlert.toggle()
            return
        }
        
        if balance ?? 0 <= 0 || balance == nil || balance!.isNaN || balance!.isInfinite {
            alertItem = TrackerAlertContext.invalidAccountBalance
            showAlert.toggle()
            return
        }
        
        if (accountType == .credit && (maxCredit ?? 0 <= 0)) ||
            (accountType == .credit && maxCredit == nil) ||
            (accountType == .credit && maxCredit!.isNaN) ||
            (accountType == . credit && maxCredit!.isInfinite) {
            alertItem = TrackerAlertContext.invalidAccountMaxCredit
            showAlert.toggle()
            return
        }
        
        if colorHex == nil || colorHex!.isEmpty || colorHex!.count != 7 || !colorHex!.hasPrefix("#") {
            alertItem = TrackerAlertContext.invalidAccountColor
            showAlert.toggle()
            return
        }
        
        withAnimation {
            let account = Account(
                name: name,
                balance: balance ?? 0,
                colorHex: colorHex ?? "#FFFFFF",
                type: accountType,
                currency: currency ?? Currency(),
                maxCredit: accountType == .credit ? maxCredit : nil
            )
            modelContext.insert(account)
            dismiss()
        }
    }
}

#Preview {
    AddAccountView()
        .modelContainer(for: [Account.self, Currency.self], inMemory: true)
}
