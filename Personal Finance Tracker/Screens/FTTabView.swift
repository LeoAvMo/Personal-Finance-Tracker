//
//  FTTabView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 24/07/25.
//

import SwiftUI
import SwiftData

struct FTTabView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var user: PFTUser
    var body: some View {
        TabView {
            Tab("Transactions", systemImage: "dollarsign") {
                TransactionsView(user: user)
            }
            
            Tab("Accounts", systemImage: "person.badge.key") {
                AccountsView()
            }
            
            Tab("Credit", systemImage: "creditcard"){
                CreditView()
            }
            
            Tab("Summary", systemImage: "chart.bar.xaxis") {
                SummaryView()
            }
            
        }
        
    }
}

#Preview {
    FTTabView(user: PFTUser())
        .modelContainer(for: PFTUser.self, inMemory: true)
}
