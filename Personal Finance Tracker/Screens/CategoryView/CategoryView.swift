//
//  CategoriesView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 22/09/25.
//

import SwiftUI
import SwiftData



// TODO: Make option to move all category transactions to another category or completely delete all transactions when category is erased.

struct CategoryView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Category.name) private var categories: [Category]
    @Query private var transactions: [Transaction]
    
    @State private var showAlert: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var alertItem: TrackerAlertItem?
    
    @State private var alertType: AlertType = .cancel
    @State private var categoryIndex = IndexSet()
    
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
                .onDelete(perform: { index in
                    if categories.count == 1 {
                        alertType = .cancel
                        showAlert.toggle()
                        alertItem = TrackerAlertContext.categoriesCannotBeEmpty
                        return
                    }
                    alertType = .delete
                    categoryIndex = index
                    showAlert.toggle()
                })
            }
            .toolbar {
                NavigationLink{
                    AddCategoryView()
                } label: {
                    Button("Add Category", systemImage: "plus"){ }
                }
            }
            .alert(isPresented: $showAlert) {
                switch alertType {
                    case .cancel: {
                        Alert(title: alertItem!.alertTitle,
                              message: alertItem!.alertMessage,
                              dismissButton: alertItem!.alertDismissButton)
                    }()
                    case .delete: {
                        Alert(title: Text("Are you sure you want to delete the category?"), message: Text("Deleting a category will also delete all transactions associated with it. Do you want to continue?"), primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("Delete"), action:{ deleteCategory(categoryIndex)}))
                    }()
                }
            
                
            }
            .navigationTitle(Text("Categories"))
        }
    }
    
    func deleteCategory(_ indexSet: IndexSet) {
        
        for index in indexSet {
            let category = categories[index]
            for transaction in transactions {
                if transaction.category == category {
                    modelContext.delete(transaction)
                }
            }
            modelContext.delete(category)
        }
    }
}

#Preview {
    CategoryView()
        .modelContainer(for: Category.self, inMemory: true)
}
