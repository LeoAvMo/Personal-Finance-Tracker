//
//  TransactionListingView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 13/09/25.
//
// TransactionListingView.swift

import SwiftUI
import SwiftData

struct TransactionListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Transaction.date, order: .reverse) var transactions: [Transaction]
    @Query(sort: \Category.name) private var categories: [Category]
    
    @State private var selectedCategory: Category?
    
    @State private var showAlert: Bool = false
    
    init(sort: SortDescriptor<Transaction>, searchString: String) {
        _transactions = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.label.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    var body: some View {
        List {
            Section(header: Text("Categories")){
                CategorySelectorView(categories: categories, selectedCategory: $selectedCategory)
            }
            
            Section(header: Text("Transactions")) {
                if transactions.isEmpty {
                    ContentUnavailableView("No Transactions Found", systemImage: "magnifyingglass")
                } else {
                    ForEach(transactions) { transaction in
                        IndividualTransactionView(transaction: transaction)
                    }
                    .onDelete(perform: deleteTransactions)
                }
            }
        }
    }
    
    func deleteTransactions(_ indexSet: IndexSet) {
        for index in indexSet {
            showAlert = true
            // Add alert that the transaction will be undone.
            let transaction = transactions[index]
            modelContext.delete(transaction)
        }
    }
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
