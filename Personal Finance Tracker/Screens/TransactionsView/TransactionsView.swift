//
//  TransactionsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI

struct TransactionsView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink {
                    AddTransactionView()
                } label: {
                    Text("Example transaction")
                }
            }
            .navigationTitle("Transactions")
        }
        
    }
}

#Preview {
    TransactionsView()
}
