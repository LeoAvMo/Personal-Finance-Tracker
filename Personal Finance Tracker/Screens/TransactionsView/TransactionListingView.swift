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
    @State private var transactionIndex = IndexSet()
    @State private var alertItem: TrackerAlertItem?
    @State private var alertType: AlertType = .cancel
    
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
                    .onDelete(perform: { index in
                        alertType = .delete
                        transactionIndex = index
                        showAlert.toggle()
                    })
                }
            }
        }
        .alert(isPresented: $showAlert) {
            switch alertType {
                case .cancel: {
                    Alert(title: alertItem!.alertTitle, message: alertItem!.alertMessage, dismissButton: alertItem!.alertDismissButton)
                }()
                case .delete: {
                    Alert(title: Text("Are you sure you want to delete the transaction?"), message: Text("Deleting a transaction will undo the changes to the balance of the account associated with it. Do you want to continue?"), primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("Delete"), action:{ deleteTransactions(transactionIndex)}))
                }()
            }
        }
    }
    
    func deleteTransactions(_ indexSet: IndexSet) {
        for index in indexSet {
            let transaction = transactions[index]
            
            if transaction.amount >= 0 {
                
                if (transaction.amount - transaction.targetAccount!.balance) > 0 {
                    alertType = .cancel
                    alertItem = TrackerAlertContext.negativeAccountBalance
                    showAlert.toggle()
                    return
                }
                
                transaction.targetAccount!.balance -= transaction.amount
                
            } else {
                transaction.targetAccount!.balance += -transaction.amount
            }
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
