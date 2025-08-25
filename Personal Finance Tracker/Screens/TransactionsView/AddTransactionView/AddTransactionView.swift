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
    @State private var amount: Float = 0
    @State private var selectedCurrency: String = "MXN"
    @State private var selectedDate: Date = Date()
    @Binding public var isShowingAddTransactionView: Bool
    // @State private var selectedTCategory: Category = Category(id: "1", name: "Groceries")
    var body: some View {
        NavigationStack{
            VStack {
                Form{
                    TextField("Label", text: $transactionLabel)
                    
                    //
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Transaction type")) {
                        Text("Income 📈").tag(1)
                        Text("Expense 📉").tag(2)
                    }
                    
                    //MAKE REGEX TO VALIDATE AMOUNT. Add error if amount is not a numerical value
                    HStack{
                        Text("Amount")
                        Spacer()
                        
                        TextField("$", value: $amount, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        Text(selectedCurrency)
                    }
                    
                    //Date
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
                                NavigationLink{
                                    CreateCategoryView()
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
                    isShowingAddTransactionView.toggle()
                } label: {
                    Text("Add Transaction")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .glassEffect(.regular.tint(.accent.opacity(0.9)).interactive())
                
                .padding(.horizontal)
            }
            .background(.background)
            .navigationTitle("Add transaction")
        }
        .overlay(GeneralDismissButton(isShowingDetail: $isShowingAddTransactionView), alignment: .topTrailing)
    }
}

#Preview {
    AddTransactionView(isShowingAddTransactionView: .constant(true))
}

struct GeneralDismissButton: View {
    @Binding var isShowingDetail: Bool
    var body: some View {
        Button{
            isShowingDetail = false
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(.accent)
                .frame(width: 20, height: 30)
        }
        .buttonStyle(.glass)
        .padding()
    }
}

