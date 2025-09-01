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
    @State private var transactionLabel: String = ""
    @State private var transactionType: TransactionType = .income
    @State private var selectedCurrency: Currency?
    @State private var amount: Double = 0.0
    @State private var selectedDate: Date = Date()
    @State private var selectedCategory: Category?
    @State private var selectedAccount: Account?
    
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
                    TextField("Label", text: $transactionLabel)
                    
                    // Transaction type. Select if transaction is an income or an expense
                    Picker(selection: $transactionType, label: Text("Transaction Type")) {
                        Text("Income 📈").tag(TransactionType.income)
                        Text("Expense 📉").tag(TransactionType.expense)
                    }
                    .pickerStyle(.menu)
                    
                    // Select currency
                    Picker(selection: $selectedCurrency, label: Text("Currency")) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency.code + currency.flag).tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    // Amount
                    HStack{
                        Text("Amount")
                        Spacer()
                        TextField("$", value: $amount, format: .currency(code: selectedCurrency?.code ?? "USD"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .fontWeight(.semibold)
                            .foregroundStyle(amountColor)
                    }
                    
                    // Transaction date
                    DatePicker(selection: $selectedDate, displayedComponents: .date, label: { Text("Date") })
                    
                    
                    // Transaction category
                    CategorySelectorView(categories: categories, selectedCategory: $selectedCategory, isShowingCreateCategoryView: $isShowingCreateCategoryView)
                    
                    // Target account
                    NavigationLink {
                        SelectAccountView(selectedAccount: $selectedAccount)
                    } label: {
                        HStack{
                            Text("Account")
                            Spacer()
                            Text(selectedAccount?.name ?? "Select Account")
                                .foregroundStyle(selectedAccount == nil ? .secondary : selectedAccount?.color ?? .secondary)
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                Button{
                   print("Transaction Added!")
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
                selectedCategory = categories.first!
                selectedCurrency = currencies.first!
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

