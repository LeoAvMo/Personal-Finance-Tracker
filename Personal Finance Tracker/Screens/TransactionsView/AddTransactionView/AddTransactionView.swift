//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 15/08/25.
//



import SwiftUI
import SwiftData

//TODO: Check why the navigation is not working and returning when adding new trsansaction

enum TransactionType : String, CaseIterable, Identifiable {
    case income, expense
    var id: Self { self }
}

struct AddTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var label: String = ""
    @State private var amount: Double = 0
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
                Button("Add transaction", systemImage: "checkmark", action: addTransaction)
                    .foregroundStyle(.accent)
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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
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
        let transaction = Transaction(label: label, amount: amount,  date: date, category: category, targetAccount: account, currency: currency)
        modelContext.insert(transaction)
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
