//
//  TransactionsSetupView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 19/09/25.
//

import SwiftUI
import SwiftData


// TODO: Add an OOPS! view when there are no currencies or accounts in the user profile.
// TODO: Make addCategoryView dissmiss itself when creating a category.

struct TransactionsSetupView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var categories: [Category]
    @Query private var currencies: [Currency]
    @Query private var accounts: [Account]
    
    @State private var showAddCategory: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertItem: TrackerAlertItem?
    
    var categoriesIsEmpty: Bool {
        categories.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if (!categoriesIsEmpty && currencies.isEmpty) || (!categoriesIsEmpty && accounts.isEmpty) {
                    Image(systemName: "eyes.inverse")
                        .font(.system(size: 70))
                        .foregroundStyle(.accent)
                        
                    Text("Oops...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("It looks like you haven't created a currency or an account yet. Add them in them in the menu on the bottom to get started!")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                } else {
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(.accent)
                    
                    Text("Before you start...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Categories are used to organize transactions depending on what they are for. Add them for each type of expense or income you have.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button {
                        if !categoriesIsEmpty {
                            alertItem = TrackerAlertContext.categoryAlreadyCreated
                            showAlert.toggle()
                            return
                        }
                        
                        showAddCategory.toggle()
                        
                    } label: {
                        Label(categoriesIsEmpty ? "Create a Category" : "Category Added", systemImage: categoriesIsEmpty ? "plus.circle.fill" : "checkmark.circle.fill")
                    }
                    .tint(categoriesIsEmpty ? .accentColor : .green)
                    .buttonStyle(.glass)
                    .padding(.top)
                }
                
                
                
            }
            .navigationTitle(Text("Add a Category"))
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: alertItem!.alertTitle,
                      message: alertItem!.alertMessage,
                      dismissButton: alertItem!.alertDismissButton)
            }
        }
    }
}

#Preview {
    TransactionsSetupView()
        .modelContainer(for: [Category.self, Currency.self, Account.self])
}
