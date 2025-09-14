//
//  TransactionsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI
import SwiftData
struct TransactionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var user: PFTUser
    
    var body: some View {
        NavigationSplitView{
            List{
                Section(header: Text("Total transactions")){
                    
                }
                Section(header: Text("Transactions")){
                    ForEach(user.transactions){ transaction in
                        IndividualTransactionView(transaction: transaction)
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink{
                        AddTransactionView(transactions: $allTransactions)
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
    TransactionsView(user: PFTUser())
        .modelContainer(for: PFTUser.self, inMemory: true)
}

struct IndividualTransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        HStack{
            let isIncome = transaction.amount > 0
            CategoryIconView(category: transaction.category ?? Category(), showLabel: true, isSelected: false)
            VStack(alignment: .leading){
                Text(transaction.label)
                    .font(.title2)
                Text(transaction.date, format: .dateTime.day().month().year())
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Divider()
                Text(transaction.targetAccount.name)
                    .font(.body)
                    .foregroundStyle(.primary)
                HStack{
                    Text(transaction.amount , format: .currency(code: transaction.currency.code))
                        .bold()
                        .fontWeight(.semibold)
                        .foregroundStyle(isIncome ? .green : .red)
                    Image(systemName: isIncome ? "chart.line.uptrend.xyaxis" : "chart.line.downtrend.xyaxis")
                        .fontWeight(.semibold)
                        .foregroundStyle(isIncome ? .green : .red)
                }
            }
            .padding(.leading)
        }
    }
}
