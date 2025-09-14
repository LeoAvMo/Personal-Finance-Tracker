//
//  TransactionsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

// TODO: CREATE ADD TRANSACTION FUNCTION

import SwiftUI
import SwiftData

struct TransactionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var user: PFTUser
    
    @State private var sortOrder = SortDescriptor(\Transaction.date, order: .reverse)
    @State private var searchString = ""
    
    var body: some View {
        NavigationStack{
            TransactionListingView(user: user, sortDescriptor: sortOrder, searchString: searchString)
            .navigationTitle("Transactions")
            .searchable(text: $searchString, prompt: "Search Transaction")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Most Recent").tag(SortDescriptor(\Transaction.date, order: .reverse))
                        Text("Oldest").tag(SortDescriptor(\Transaction.date, order: .forward))
                        Text("Alphabetical").tag(SortDescriptor(\Transaction.label))
                        Text("Highest to Lowest").tag(SortDescriptor(\Transaction.amount, order: .reverse))
                        Text("Lowest to Highest").tag(SortDescriptor(\Transaction.amount, order: .forward))
                    }
                    .pickerStyle(.inline)
                }
                Button("Add Transaction",systemImage: "plus", action: addTransaction)
            }
        }
    }
    
    // MARK: Functions
    private func addTransaction() {
        withAnimation {
            let account = user.accounts.first ?? Account()
            let currency = account.currency
            let transaction = Transaction(targetAccount: account, currency: currency)
            user.transactions.append(transaction)
        }
    }
}


#Preview {
    TransactionsView(user: PFTUser())
        .modelContainer(for: [PFTUser.self, Transaction.self], inMemory: true)
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

