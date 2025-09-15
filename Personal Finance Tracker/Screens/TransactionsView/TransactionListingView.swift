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
                        // The file you provided didn't include this view,
                        // but your original project did. Assuming it exists.
                        // If not, replace with: Text(transaction.label)
                        IndividualTransactionView(transaction: transaction)
                    }
                    .onDelete(perform: deleteTransactions)
                }
            }
        }
    }
    
    func deleteTransactions(_ indexSet: IndexSet) {
        for index in indexSet {
            let transaction = transactions[index]
            modelContext.delete(transaction)
        }
    }
}
