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
    @State private var selectedCurrency: Currency = MockData().mockCurrencies.first!   // Make this the user's default currency
    @State private var selectedDate: Date = Date()
    @State private var isShowingCreateCategoryView: Bool = false
    
    // @State private var selectedTCategory: Category = Category(id: "1", name: "Groceries")
    
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
                        TextField("$", value: $amount, format: .currency(code: selectedCurrency.code))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(amountColor)
                    }
                    
                    // Transaction date
                    DatePicker(selection: $selectedDate, displayedComponents: .date, label: { Text("Date") })
                        
                    // Transaction type
                    VStack(alignment: .leading){
                        Text("Category")
                        ScrollView(.horizontal, showsIndicators: true){
                            HStack {
                                Button {
                                    
                                } label: {
                                    CategoryIconView(categoryName: "Accesories", iconColor: .pink, iconImageName: "bag", showLabel: true, isSelected: true)
                                }
                                Button{
                                    isShowingCreateCategoryView.toggle()
                                } label: {
                                    CategoryIconView(categoryName: "Add", iconColor: Color(red: 0/255, green: 209/255, blue: 255/255), iconImageName: "plus", showLabel: true, isSelected: false)
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
