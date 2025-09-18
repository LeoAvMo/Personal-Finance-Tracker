//
//  AddCurrency.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI
import SwiftData
import Combine
import RegexBuilder

struct AddCurrencyView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var code: String = ""
    @State private var flag: String = ""
    @State private var value: Double?
    
    @State private var showAlert: Bool = false
    @State private var alertItem: TrackerAlertItem?
    
    var body: some View {
        NavigationStack{
            
            Form {
                TextField("Name", text: $name)
                
                // TODO: limit to 3 chars
                TextField("Currency ISO Code. Ex: USD", text: $code)
                    .onReceive(Just(code)) { _ in limitText(textLimit: 3) }
                
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
            .alert(isPresented: $showAlert) {
                Alert(title: alertItem!.alertTitle,
                      message: alertItem!.alertMessage,
                      dismissButton: alertItem!.alertDismissButton)
            }
        }
    
    }
    
    private func addCurrency() {
        // TODO: Add checks to not add when there are nil values, empty strings or value set to 0.
        
        code = code.uppercased()
        
        // Check if currency name is correct
        if name.isEmpty {
            alertItem = TrackerAlertContext.categoryNameIsRequired
            showAlert.toggle()
            return
        }
        
        // Check with regex that ISO code is only 3 chars and from a-z and A-Z
        if !isValidISOCode(ISOCode: code) {
            alertItem = TrackerAlertContext.currencyISOCodeIsIncorrect
            showAlert.toggle( )
            return
        }
    
        // Check if flag is an emoji with a single char
        if !flag.isSingleEmoji {
            alertItem = TrackerAlertContext.currencyHasNoFlag
            showAlert.toggle()
            return
        }
        
        if value ?? 0 <= 0 || value == nil || value!.isNaN || value!.isInfinite {
            alertItem = TrackerAlertContext.currencyAmountIsNotValid
            showAlert.toggle()
            return
        }
        
        withAnimation {
            let currency = Currency(name: name, code: code, flag: flag, value: value ?? 1)
            modelContext.insert(currency)
            dismiss()
        }
    }
    
    //Function to keep text length in limits
    private func limitText(textLimit : Int) {
        if code.count > textLimit {
            code = String(code.prefix(textLimit))
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
