//
//  CategoriesView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 22/09/25.
//

import SwiftUI
import SwiftData


// TODO: Make option to move all category transactions to another category or completely delete all transactions when category is erased.
// TODO: Make .onDelete modifier for list and sorting option.
struct CategoryView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Category.name) private var categories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    HStack{
                        CategoryIconView(category: category, showLabel: false, isSelected: false)
                        Text(category.name)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(category.color)
                    }
                }
            }
            .toolbar {
                NavigationLink{
                    AddCategoryView()
                } label: {
                    Button("Add Category", systemImage: "plus"){ }
                }
            }
            .navigationTitle(Text("Categories"))
        }
    }
}

#Preview {
    CategoryView()
        .modelContainer(for: Category.self, inMemory: true)
}
