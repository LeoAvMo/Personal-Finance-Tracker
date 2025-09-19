//
//  AccountCurrencySetupView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI
import SwiftData


struct AccountCurrencySetupView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Account.name) var accounts: [Account]
    @Query(sort: \Currency.name) var currencies: [Currency]
    
    @State private var showAddCurrency: Bool = false
    @State private var showAddAccount: Bool = false
    @State private var showAlert: Bool = false
    
    
    var body: some View {
        
        
        
        NavigationStack{
            VStack(spacing: 20) {
                
                CurrenciesAccountIndicator
                
                Spacer()
                Image(systemName: "list.bullet.clipboard.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.secondary)
                
                Text("Let's Get Set Up!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Start by creating one currency and one account to your profile to begin tracking your finances. Create a currency before creating an account.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Button to open the CreateCategoryView sheet
                Button {
                    if !currencies.isEmpty{
                        // Add alert
                        return
                    }
                    showAddCurrency.toggle()
                } label: {
                    Label("Create a Currency", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.white)
                .padding(.top)
                
                
                // Button to open a placeholder AddAccountView sheet
                Button {
                    if currencies.isEmpty{
                        //TODO: Add alert
                        return
                    }
                    showAddAccount.toggle()
                } label: {
                    Label("Create an Account", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            .navigationTitle("Setup")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddCurrency){
                AddCurrencyView()
            }
            .sheet(isPresented: $showAddAccount){
                AddAccountView()
            }
        }
    }
    
    private var CurrenciesAccountIndicator: some View {
        HStack (spacing: 20){
            VStack{
                ZStack{
                    Circle()
                        .stroke(.accent, lineWidth: 3)
                        .fill(currencies.isEmpty ? Color.gray.opacity(0) : Color.accentColor)
                        .frame(height: 50)
                    Image(systemName: "dollarsign")
                        .foregroundStyle(currencies.isEmpty ? Color.accentColor : .white)
                        .bold()
                        .font(.title3)
                    
                }
                    Text("Add Currency")
                        .font(.caption)
                        .foregroundStyle(Color.accentColor)
            }
            .overlay(alignment: .topTrailing){
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(!currencies.isEmpty ? Color.accentColor : Color.gray.opacity(0))
                    .offset(x: 3, y: -7)
            }
            
            
            Image(systemName: "arrow.right")
                .symbolEffect(.wiggle.byLayer, options: .repeat(.periodic(delay: 3)))
                .foregroundStyle(Color.accentColor)
                .bold()
                .font(.title3)
                .padding(.bottom, 18)
            
            VStack{
                ZStack{
                    Circle()
                        .stroke(.accent, lineWidth: 3)
                        .fill(accounts.isEmpty ? Color.gray.opacity(0) : Color.accentColor)
                        .frame(height: 50)
                    Image(systemName: "creditcard.fill")
                        .foregroundStyle(accounts.isEmpty ? Color.accentColor : .white)
                        .bold()
                        .font(.title3)
                    
                }
                    Text("Add Account")
                        .font(.caption)
                        .foregroundStyle(Color.accentColor)
            }
            .overlay(alignment: .topTrailing){
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(!accounts.isEmpty ? Color.accentColor : Color.gray.opacity(0))
                    .offset(x: 3, y: -7)
            }
        }
    }
}

#Preview {
    AccountCurrencySetupView()
        .modelContainer(for: [Currency.self, Account.self], inMemory: true)
}
