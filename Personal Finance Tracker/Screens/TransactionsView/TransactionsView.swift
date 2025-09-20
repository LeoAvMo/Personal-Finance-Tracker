//
//  TransactionsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

// TODO: Check why the navigation is not working and returning when adding new trsansaction

// TODO: Add edit settings for transactions and deletions

import SwiftUI
import SwiftData

struct TransactionsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path: [Transaction] = [Transaction]()
    
    @Query private var currencies: [Currency]
    @Query private var categories: [Category]
    @Query private var accounts: [Account]
    
    @State private var sortOrder = SortDescriptor(\Transaction.date, order: .reverse)
    @State private var searchString = ""
    @State private var selectedCategory: Category?
    var body: some View {
        NavigationStack(path: $path){
            if categories.isEmpty || accounts.isEmpty || currencies.isEmpty {
                TransactionsSetupView()
            } else {
                TransactionListingView(sort: sortOrder, searchString: searchString)
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
                    NavigationLink{
                        AddTransactionView()
                    } label: {
                        Button("Add Transaction",systemImage: "plus"){ }
                    }
                    
                }
            }
            
        }
    }
    
    // MARK: Functions
    private func addTransaction() {
        withAnimation {
            let transaction = Transaction(label: "", category: categories.first, targetAccount: accounts.first, currency: currencies.first)
            modelContext.insert(transaction)
            path = [transaction]
        }
    }
}


#Preview {
    TransactionsView()
        .modelContainer(for: [Transaction.self, Currency.self, Account.self, Category.self], inMemory: true)
}

struct IndividualTransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        HStack{
            let isIncome = transaction.amount > 0
            CategoryIconView(category: transaction.category, showLabel: true, isSelected: false)
            VStack(alignment: .leading){
                Text(transaction.label)
                    .font(.title2)
                Text(transaction.date, format: .dateTime.day().month().year())
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Divider()
                Text(transaction.targetAccount?.name ?? "No Account")
                    .font(.body)
                    .foregroundStyle(.primary)
                HStack{
                    Text(transaction.amount , format: .currency(code: transaction.currency?.code ?? "USD"))
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

