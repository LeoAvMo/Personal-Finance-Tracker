//
//  AccountCurrencySetupView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI

struct AccountCurrencySetupView: View {
    @State private var showAddCurrency: Bool = false
    @State private var showAddAccount: Bool = false
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Image(systemName: "list.bullet.clipboard.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.secondary)
                
                Text("Let's Get Set Up!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Start by creating one currency and one account to your profile to begin tracking your finances.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Button to open the CreateCategoryView sheet
                Button {
                    showAddCurrency.toggle()
                } label: {
                    Label("Create a Currency", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.primary)
                .padding(.top)
                
                // Button to open a placeholder AddAccountView sheet
                Button {
                    showAddAccount.toggle()
                } label: {
                    Label("Create an Account", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.bordered)
                
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
}

#Preview {
    AccountCurrencySetupView()
}
