//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 15/08/25.
//

import SwiftUI
import SwiftData

enum TransactionType : String, CaseIterable, Identifiable {
    case income, expense
    var id: Self { self }
}

enum TransactionFields: Hashable {
    case label, amount
}
struct AddTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var label: String = ""
    @State private var amount: Double?
    @State private var transactionType: TransactionType = .expense
    @State private var account: Account?
    @State private var category: Category?
    @State private var date: Date = Date()
    
    @State private var alertItem: TrackerAlertItem?
    @State private var showAlert: Bool = false
    
    @Query(sort: \Account.name) private var accounts: [Account]
    @Query(sort: \Category.name) private var categories: [Category]
    
    @FocusState private var focusedField: TransactionFields?
    
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
                    Button("Create Transaction", systemImage: "checkmark", action: addTransaction)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: alertItem!.alertTitle,
                      message: alertItem!.alertMessage,
                      dismissButton: alertItem!.alertDismissButton)
            }
            .onAppear {
                focusedField = .label
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
                .focused($focusedField, equals: .label)
                .onSubmit {
                    focusedField = .amount
                }
            
            Picker(selection: $transactionType, label: Text("Transaction Type")) {
                Text("Income 📈").tag(TransactionType.income)
                Text("Expense 📉").tag(TransactionType.expense)
            }
            .pickerStyle(.menu)
            
            VStack(alignment: .leading){
                HStack{
                    Text("Amount")
                    TextField("$", value: $amount, format: .currency(code: account?.currency.code ?? ""))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .fontWeight(.semibold)
                        .foregroundStyle(amountColor)
                }
                .padding(.bottom, 4)
                
                Text("Currency is set depending on the target account's curency.")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
                    
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
                            AccountDescriptionListView(account: acc, transactionAmount: amount, transactionType: transactionType, isSelected: account == acc)
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
        
        // MARK: Alerts
        
        // Name is empty
        if label.isEmpty {
            alertItem = TrackerAlertContext.transactionLabelIsEmpty
            showAlert.toggle()
            return
        }
        
        // Amount is nil, nan, infinite, or less than 0
        if amount ?? 0 <= 0 || amount == nil || amount!.isNaN || amount!.isInfinite {
            alertItem = TrackerAlertContext.invalidAmount
            showAlert.toggle()
            return
        }
        
        // Categories is nil
        if category == nil {
            alertItem = TrackerAlertContext.categoryIsEmpty
            showAlert.toggle()
            return
        }
        
        // Account is nil
        if account == nil {
            alertItem = TrackerAlertContext.accountIsEmpty
            showAlert.toggle()
            return
        }
        
        // Add alert account balance will be less than 0 after decreasing.
        if transactionType == .expense && ((account!.balance - amount!) < 0) {
            alertItem = TrackerAlertContext.nonSufficientFunds
            showAlert.toggle()
        }
        
        // MARK: Things to do after validating
        
        // Make target account balance decrease or increase depending if user selected transaction or expense
        if transactionType == .expense {
            account!.balance -= amount!
        } else {
            account!.balance += amount!
        }
        
        // Put transaction into the list
        let transaction = Transaction(label: label, amount: transactionType == .expense ? -amount! : amount!,  date: date, category: category, targetAccount: account, currency: account!.currency)
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
