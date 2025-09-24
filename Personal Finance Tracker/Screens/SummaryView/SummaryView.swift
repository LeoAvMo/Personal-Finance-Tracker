//
//  SummaryView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI
import SwiftData
import Charts

// TODO: Charts: Transactions per category, Transactions per account, spent per time (today, last seven days, last month, las six months, last year), how much balance is left at the end of each month

struct SummaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Category.name) private var categories: [Category]
    @Query(sort: \Transaction.label) private var transactions: [Transaction]
    
    @State private var selectedCategory: Category?
    
    var body: some View {
        NavigationStack{
            ScrollView {
                CategoriesSelectorView(categories: categories, selectedCategory: $selectedCategory)
                
                HStack{
                    VStack(spacing: 0){
                        Text("2200")    // number of transactions of selected category
                            .font(.system(size: 60))
                            .bold()
                            .foregroundStyle(selectedCategory?.color ?? .gray)
                        Text("\(selectedCategory?.name ?? "No") transactions")
                            .font(.body)
                            .foregroundStyle(selectedCategory?.color.opacity(0.5) ?? .gray.opacity(0.5))
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Summary")
            .toolbar{
                NavigationLink{
                    CategoryView()
                } label: {
                    Button("Add Category", systemImage: "plus"){ }
                }
            }
        }
    }
}

#Preview {
    SummaryView()
        .modelContainer(for: [Category.self, Transaction.self], inMemory: true)
}

struct CategoriesSelectorView: View {
    var categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            // Assuming CategoryIconView exists from your project
                            CategoryIconView(category: category, showLabel: true, isSelected: category == selectedCategory)
                                
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
        }
    }
}

