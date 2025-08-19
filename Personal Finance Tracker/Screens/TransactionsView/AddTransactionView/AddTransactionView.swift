//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 15/08/25.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var label: String = ""
    @State private var amount: Float = 0
    var body: some View {
        NavigationStack{
            Form{
                TextField("Label", text: $label)
                //
                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Transaction type")) {
                    Text("Income 📈").tag(1)
                    Text("Expense 📉").tag(2)
                }
                
                //Add error if amount is not a numerical value
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                
                // Date field
                Text("Date")
                // Transaction type
                Text("Category")
                // Target account
                Text("Account")
            }
            .navigationTitle("Add transaction")

        }
    }
}

#Preview {
    AddTransactionView()
}
