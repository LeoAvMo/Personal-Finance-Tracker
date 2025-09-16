//
//  AddCurrency.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI
import SwiftData

struct AddCurrency: View {
    @Environment(\.modelContext) private var modelContext
    @State private var name: String = ""
    @State private var code: String = ""
    @State private var flag: String = ""
    @State private var value: Double = 0

    var body: some View {
        NavigationStack{
            
            Form {
                TextField("Name", text: $name)
                TextField("Currency code, Ex: USD", text: $code)
                // Block to one char
                TextField("Flag", text: $flag)
                VStack {
                    HStack{
                        Text("Value")
                        TextField("$", value: $value, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                    }
                    .padding(.bottom)
                    VStack{
                        Text("Tip: Make sure that the value of the currency is based in your most used currency. For example, if you use the US dollar as your base currency, you should set the value of the currency to 1.")
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                    }
                }
                
                
            }
            .navigationTitle(Text("Add Currency"))
            .toolbar {
                Button("Create Currency", systemImage: "checkmark", action: addCurrency)
            }
        }
    }
    
    private func addCurrency() {
        // TODO: Add checks to not add when there are nil values, empty strings or value set to 0.
        withAnimation {
            let currency = Currency(name: name, code: code, flag: flag, value: value)
            modelContext.insert(currency)
        }
    }
}

#Preview {
    AddCurrency()
        .modelContainer(for: Currency.self, inMemory: true)
}
