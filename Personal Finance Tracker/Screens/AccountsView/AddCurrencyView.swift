//
//  AddCurrency.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI
import SwiftData

struct AddCurrencyView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var code: String = ""
    @State private var flag: String = ""
    @State private var value: Double = 1

    var body: some View {
        NavigationStack{
            
            Form {
                TextField("Name", text: $name)
                
                // TODO: limit to 3 chars
                TextField("Currency ISO Code. Ex: USD", text: $code)
                
                
                EmojiTextFieldView(emojiText: $flag)
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
            dismiss()
        }
    }
}

#Preview {
    AddCurrencyView()
        .modelContainer(for: Currency.self, inMemory: true)
}

struct EmojiTextFieldView: View {
    @Binding var emojiText: String

    var body: some View {
        TextField("Flag", text: $emojiText)
            .onChange(of: emojiText) { oldValue, newValue in
                // This logic is triggered every time the text changes.
                
                // 1. Filter the new text to keep only emoji characters.
                let filtered = newValue.filter { $0.isEmoji }
                
                // 2. If the filtered string has an emoji, keep only the first one.
                if let firstEmoji = filtered.first {
                    // 3. Update the text field's value to be just that single emoji.
                    // This check prevents an infinite loop.
                    if emojiText != String(firstEmoji) {
                        emojiText = String(firstEmoji)
                    }
                } else {
                    // 4. If the filtered string is empty (no emojis), clear the text field.
                    if !emojiText.isEmpty {
                        emojiText = ""
                    }
                }
            }
    }
}
