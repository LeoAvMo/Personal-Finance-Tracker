//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 15/08/25.
//

import SwiftUI
import SwiftData

// TODO: add alerts in case of fields not selected

enum TransactionType : String, CaseIterable, Identifiable {
    case income, expense
    var id: Self { self }
}

struct AddTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var label: String = ""
    @State private var amount: Double?
    @State private var transactionType: TransactionType = .expense
    @State private var currency: Currency?
    @State private var account: Account?
    @State private var category: Category?
    @State private var date: Date = Date()
    
    @Query(sort: \Account.name) private var accounts: [Account]
    @Query(sort: \Currency.name) private var currencies: [Currency]
    @Query(sort: \Category.name) private var categories: [Category]
    
    // MARK: - Body
    var body: some View {
        NavigationStack{
            // The Form is now much simpler, calling our computed properties.
            Form {
                transactionDetailsSection
                
                Section("Category") {
                    if categories.isEmpty {
                        ContentUnavailableView("No Categories Found", systemImage: "star")
                    } else {
                        CategorySelectorView(categories: categories, selectedCategory: $category)
                    }
                    
                }
                accountSelectorSection
            }
            .background(.background)
            .navigationTitle("Transaction")
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Create Currency", systemImage: "checkmark", action: addTransaction)
                }
            }
            .onAppear {
                currency = currencies.first
                account = accounts.first
                category = categories.first
            }
        }
    }
    
    // MARK: - Computed Properties for Form Sections
    
    /// A computed property for the main transaction details.
    private var transactionDetailsSection: some View {
        Section("Details") {
            TextField("Label", text: $label)
            
            Picker(selection: $transactionType, label: Text("Transaction Type")) {
                Text("Income 📈").tag(TransactionType.income)
                Text("Expense 📉").tag(TransactionType.expense)
            }
            .pickerStyle(.menu)
            
            Picker(selection: $currency, label: Text("Currency")) {
                ForEach(currencies) { currency in
                    Text(currency.code + currency.flag).tag(currency)
                }
            }
            .pickerStyle(.menu)
            
            HStack{
                Text("Amount")
                Spacer()
                TextField("$", value: $amount, format: .currency(code: currency?.code ?? "USD"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .fontWeight(.semibold)
                    .foregroundStyle(amountColor)
            }
            
            DatePicker(selection: $date, displayedComponents: .date, label: { Text("Date") })
        }
    }
    
    /// A computed property that uses a Picker to select an account.
    private var accountSelectorSection: some View {
        Section("Account") {
            if accounts.isEmpty {
                ContentUnavailableView("No Accounts Found", systemImage: "creditcard")
            } else {
                List {
                    ForEach(accounts) { acc in
                        Button {
                            account = acc
                        } label: {
                            AccountCapsuleView(account: acc)
                        }
                    }
                }
            }
        }
    }
    
    /// A helper computed property for the amount text color.
    private var amountColor: Color {
        switch transactionType {
            case .income:
                return .green
            case .expense:
                return .red
        }
    }
    
    func addTransaction() {
        // TODO: Add checks and alerts for transaction
        
        // MARK: Alerts
        
        // Name is empty
        
        // Currency is nil
        
        // Amount is nil, nan, infinite, or less than 0
        
        // Categories is nil
        
        // Account is nil
        
        // MARK: Things to do after validating
        
        // Make target account balance decrease or increase depending if user selected transaction or expense
        
        // add alert account balance will be less than 0 after decreasing.
        
        // Put transaction into the list
        let transaction = Transaction(label: label, amount: amount ?? 0,  date: date, category: category, targetAccount: account, currency: currency)
        modelContext.insert(transaction)
        
        dismiss()
    }
    
}

// MARK: - Preview
#Preview {
    AddTransactionView()
        .modelContainer(for: [Transaction.self, Currency.self , Category.self, Account.self], inMemory: true)
}

// MARK: - Subviews
struct CategorySelectorView: View {
    var categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            // Assuming CategoryIconView exists from your project
                            CategoryIconView(category: category, showLabel: true, isSelected: category == selectedCategory)
                        }
                    }
                }
            }
        }
    }
}
