//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 15/08/25.
//

import SwiftUI

enum TransactionType : String, CaseIterable, Identifiable {
    case income, expense
    var id: Self { self }
}

struct AddTransactionView: View {
    //Private
    @State private var transaction = Transaction(transactionLabel: "",
                                                 transactionCurrency: nil,
                                                 transactionAmount: 0.0,
                                                 transactionDate: Date(),
                                                 transactionCategory: nil,
                                                 transactionAccount: nil)
    @State private var transactionType: TransactionType = .income
    @State private var alertItem: TrackerAlertItem?
    @State private var showAlert: Bool = false
    // Turn these to ENVIRONMENT variables for all of the user's data
    @State private var currencies: [Currency] = MockData.mockCurrencies
    @State private var categories: [Category] = MockData.mockCategories
    @State private var accounts: [Account] = MockData.mockAccounts
    
    // Used for create Category view toggle
    @State private var isShowingCreateCategoryView: Bool = false
    
    private var amountColor: Color {
        switch transactionType {
            case .income:
                return .green
            case .expense:
                return .red
        }
    }
    
    var body: some View {

        NavigationStack{
            VStack {
                Form{
                    
                    // Transaction name
                    TextField("Label", text: $transaction.transactionLabel)
                    
                    // Transaction type. Select if transaction is an income or an expense
                    Picker(selection: $transactionType, label: Text("Transaction Type")) {
                        Text("Income 📈").tag(TransactionType.income)
                        Text("Expense 📉").tag(TransactionType.expense)
                    }
                    .pickerStyle(.menu)
                    
                    // Select currency
                    Picker(selection: $transaction.transactionCurrency, label: Text("Currency")) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency.code + currency.flag).tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    // Amount
                    HStack{
                        Text("Amount")
                        Spacer()
                        TextField("$", value: $transaction.transactionAmount, format: .currency(code: transaction.transactionCurrency?.code ?? "USD"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .fontWeight(.semibold)
                            .foregroundStyle(amountColor)
                    }
                    
                    // Transaction date
                    DatePicker(selection: $transaction.transactionDate, displayedComponents: .date, label: { Text("Date") })
                    
                    // Transaction category
                    CategorySelectorView(categories: categories, selectedCategory: $transaction.transactionCategory, isShowingCreateCategoryView: $isShowingCreateCategoryView)
                    
                    // Target account
                    NavigationLink {
                        SelectAccountView(selectedAccount: $transaction.transactionAccount)
                    } label: {
                        HStack{
                            Text("Account")
                            Spacer()
                            Text(transaction.transactionAccount?.name ?? "Select Account")
                                .foregroundStyle(transaction.transactionAccount == nil ? .secondary : transaction.transactionAccount?.color ?? .secondary)
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                Button{
                    
                    // MARK: Error cheking
                    
                    
                    if transaction.transactionLabel.isEmpty{
                        alertItem = TrackerAlertContext.transactionLabelIsEmpty
                        showAlert.toggle()
                        return
                    }
                    
                    //Currency is nil
                    if transaction.transactionCurrency == nil{
                        alertItem = TrackerAlertContext.currencyIsEmpty
                        showAlert.toggle()
                        return
                    }
                    
                    // amount is less or equal to zero, not a number or is infinite
                    if transaction.transactionAmount <= 0 || transaction.transactionAmount.isNaN || transaction.transactionAmount.isInfinite {
                        alertItem = TrackerAlertContext.invalidAmount
                        showAlert.toggle()
                        return
                    }
                    
                    // Category is nil
                    if transaction.transactionCategory == nil{
                        alertItem = TrackerAlertContext.categoryIsEmpty
                        showAlert.toggle()
                        return
                    }
                    
                    // Account is nil
                    if transaction.transactionAccount == nil{
                        alertItem = TrackerAlertContext.accountIsEmpty
                        showAlert.toggle()
                        return
                    }
                    
                    // MARK: Steps after passing all checks:
                    
                    // Turn amount to negative in case of .expense
                    
                    // Add it to the target account
                    
                    // Add it to the list of transactions the user has
                    
                    // Return to Transactions View
                    
                   print(transaction)
                } label: {
                    Text("Add Transaction")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .glassEffect(.regular.tint(.accent.opacity(0.9)).interactive())
                .padding(.horizontal)
                .padding(.bottom, 25)
            }
            .background(.background)
            .sheet(isPresented: $isShowingCreateCategoryView, content: {
                CreateCategoryView(isPresented: $isShowingCreateCategoryView)
            })
            .onAppear {
                transaction.transactionCurrency = currencies.first!
                transaction.transactionCategory = categories.first!
            }
            .alert(isPresented: $showAlert) {
                Alert(title: alertItem!.alertTitle,
                      message: alertItem!.alertMessage,
                      dismissButton: alertItem!.alertDismissButton)
            }

            .navigationTitle("Add transaction")
        }
        
    }
}

#Preview {
    AddTransactionView()
}

struct CategorySelectorView: View {
    var categories: [Category]
    @Binding var selectedCategory: Category?
    @Binding var isShowingCreateCategoryView: Bool
    var body: some View {
        VStack(alignment: .leading){
            Text("Category")
            ScrollView(.horizontal, showsIndicators: true){
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            CategoryIconView(category: category, showLabel: true, isSelected: category == selectedCategory)
                        }
                    }
                    Button{
                        isShowingCreateCategoryView.toggle()
                    } label: {
                        AddButton(showLabel: true)
                    }
                }
            }
        }
    }
}

