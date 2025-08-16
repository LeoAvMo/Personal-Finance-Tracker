//
//  FTTabView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 24/07/25.
//

import SwiftUI

struct FTTabView: View {
    var body: some View {
        TabView {
            Tab("Transactions", systemImage: "dollarsign") {
                TransactionsView()
            }
            
            Tab("Accounts", systemImage: "creditcard") {
                AccountsView()
            }
            
            Tab("Summary", systemImage: "chart.bar.xaxis") {
                SummaryView()
            }
        }
        
    }
}

#Preview {
    FTTabView()
}
