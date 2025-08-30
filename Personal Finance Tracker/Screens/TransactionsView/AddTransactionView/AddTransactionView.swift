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
    @State private var transactionLabel: String = ""
    @State private var transactionType: TransactionType = .income
    @State private var amount: Double = 0.0
    @State private var currencies: [Currency] = MockData().mockCurrencies  // Make this an environment var
    @State private var selectedCurrency: Currency?
    @State private var selectedDate: Date = Date()
    @State private var categories: [Category] = MockData().mockCategories  // Turn this to envirnment var for all of the user's categories
    @State private var selectedCategory: Category?
    
    @State private var isShowingCreateCategoryView: Bool = false
    enum TransactionType : String, CaseIterable, Identifiable {
        case income, expense
        var id : Self { self }
    }
    
    var body: some View {

        NavigationStack{
            VStack {
                Form{
                    
                    // Transaction name
                    TextField("Label", text: $transactionLabel)
                    
                    // Select if transaction is an income or an expense
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
                        var amountColor: Color {
                            switch transactionType {
                                case .income:
                                        .green
                                case .expense:
                                        .red
                            }
                        }
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
                    
                    // Transaction type
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
                    
                    // Target account
                    Text("Account")
                    
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
    var body: some View {
       
    }
}
