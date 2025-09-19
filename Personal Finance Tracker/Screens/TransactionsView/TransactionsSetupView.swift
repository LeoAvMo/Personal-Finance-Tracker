//
//  TransactionsSetupView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 19/09/25.
//

import SwiftUI
import SwiftData

struct TransactionsSetupView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var categories: [Category]
    @Query private var currencies: [Currency]
    @Query private var accounts: [Account]
    
    var categoriesIsEmpty: Bool {
        accounts.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.accent)
                    .symbolEffect(.drawOn.individually, options: .nonRepeating)
                
                Text("Add a Category!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Categories are used to organize transactions depending on what they are for. Add them for each type of expense or income you have.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button {
                    if !categoriesIsEmpty{
                        
                        return
                    }
                    
                } label: {
                    Label(categoriesIsEmpty ? "Create a Category" : "Category Added", systemImage: categoriesIsEmpty ? "plus.circle.fill" : "checkmark.circle.fill")
                }
                .tint(categoriesIsEmpty ? .accentColor : .green)
                .buttonStyle(.glass)
                .padding(.top)
                
            }
            .navigationTitle(Text("Adding Categories"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TransactionsSetupView()
        .modelContainer(for: [Category.self, Currency.self, Account.self])
}
