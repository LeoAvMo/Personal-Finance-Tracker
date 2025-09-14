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
    @Query private var transactions: [Transaction]
    
    // TransactionListingView.swift

    init(user: PFTUser, sortDescriptor: SortDescriptor<Transaction>, searchString: String) {
        // Get the user's unique identifier to use in the predicate.
        let username = user.username
        
        if searchString.isEmpty {
            // Predicate 1: Filter transactions where the user's ID matches.
            let predicate = #Predicate<Transaction> { transaction in
                transaction.user?.username == username
            }
            _transactions = Query(filter: predicate, sort: [sortDescriptor])
        } else {
            // Predicate 2: Filter by user's ID AND the search string.
            let predicate = #Predicate<Transaction> { transaction in
                transaction.user?.username == username &&
                transaction.label.localizedStandardContains(searchString)
            }
            _transactions = Query(filter: predicate, sort: [sortDescriptor])
        }
    }
    
    var body: some View {
        List {
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
