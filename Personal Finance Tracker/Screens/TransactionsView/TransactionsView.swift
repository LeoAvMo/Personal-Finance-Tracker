//
//  TransactionsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI

struct TransactionsView: View {
    
    @State private var placeholderCategory: Category = Category(id: UUID(), name: "Expenses", color: .green, iconName: "dollarsign")
    
    @State private var allTransactions: [Transaction] = []
    @State private var transaction: Transaction?
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Total transactions")){
                    
                }
                Section(header: Text("Transactions")){
                    HStack{
                        let isIncome = transaction?.transactionAmount ?? 0 > 0
                        CategoryIconView(category: transaction?.transactionCategory ?? MockData.mockCategory, showLabel: true, isSelected: false)
                        VStack(alignment: .leading){
                            Text(transaction?.transactionLabel ?? "Transaction")
                                .font(.title2)
                            Text(transaction?.transactionDate ?? Date(), format: .dateTime.day().month().year())
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Divider()
                            Text(transaction?.transactionAccount?.name ?? "Account")
                                .font(.body)
                                .foregroundStyle(.primary)
                            HStack{
                                Text(transaction?.transactionAmount ?? 0.0, format: .currency(code: transaction?.transactionCurrency?.code ?? "USD"))
                                    .bold()
                                    .fontWeight(.semibold)
                                    .foregroundStyle(isIncome ? .green : .red)
                                Image(systemName: "chart.line.downtrend.xyaxis")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(isIncome ? .green : .red)
                            }

                        }
                        .padding(.leading)
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink{
                        AddTransactionView()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundStyle(.accent)
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    TransactionsView()
}
