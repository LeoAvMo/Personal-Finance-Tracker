//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 15/08/25.
//


// AddTransactionView.swift

import SwiftUI
import SwiftData

enum TransactionType : String, CaseIterable, Identifiable {
    case income, expense
    var id: Self { self }
}

struct EditTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var transaction: Transaction
    @Query(sort: \Account.name) private var accounts: [Account]
    @Query(sort: \Currency.name) private var currencies: [Currency]
    @Query(sort: \Category.name) private var categories: [Category]
    @State private var transactionType: TransactionType = .expense
    
    // Used for create Category view toggle
    @State private var isShowingCreateCategoryView: Bool = false
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
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
                        CategorySelectorView(categories: categories, selectedCategory: $transaction.category)
                    }
                    
                }
                
                accountSelectorSection
            }
            .background(.background)
            .navigationTitle("Transaction")
        }
    }
    
    // MARK: - Computed Properties for Form Sections
    
    /// A computed property for the main transaction details.
    private var transactionDetailsSection: some View {
        Section("Details") {
            TextField("Label", text: $transaction.label)
            
            Picker(selection: $transactionType, label: Text("Transaction Type")) {
                Text("Income 📈").tag(TransactionType.income)
                Text("Expense 📉").tag(TransactionType.expense)
            }
            .pickerStyle(.menu)
            
            Picker(selection: $transaction.currency, label: Text("Currency")) {
                ForEach(currencies) { currency in
                    Text(currency.code + currency.flag).tag(currency)
                }
            }
            .pickerStyle(.menu)
            
            HStack{
                Text("Amount")
                Spacer()
                TextField("$", value: $transaction.amount, format: .currency(code: transaction.currency?.code ?? "USD"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .fontWeight(.semibold)
                    .foregroundStyle(amountColor)
            }
            
            DatePicker(selection: $transaction.date, displayedComponents: .date, label: { Text("Date") })
        }
    }
    
    /// A computed property that uses a Picker to select an account.
    private var accountSelectorSection: some View {
        Section("Account") {
            if accounts.isEmpty {
                ContentUnavailableView("No Accounts Found", systemImage: "creditcard")
            } else {
                List {
                    ForEach(accounts) { account in
                        Button {
                            transaction.targetAccount = account
                        } label: {
                            AccountCapsuleView(account: account).tag(account)
                        }
                        // Use .tag() to associate the model object with each option
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
}

// MARK: - Preview
#Preview {
    EditTransactionView(transaction: Transaction())
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
