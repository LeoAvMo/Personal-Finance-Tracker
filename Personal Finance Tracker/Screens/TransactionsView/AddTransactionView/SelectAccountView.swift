//
//  SelectAccountView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 31/08/25.
//

import SwiftUI

/*
struct SelectAccountView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var user: PFTUser
    
    @State private var columnLayout = Array(repeating: GridItem(), count: 2)
    @State private var selectedAccount: PFTAccount?
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Cash")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                    
                    LazyVGrid(columns: columnLayout){
                        ForEach(user.accounts){ account in
                            if account.type == .cash {
                                Button{
                                    selectedAccount = account
                                } label: {
                                    AccountCardView(account: account, isSelected: selectedAccount?.id == account)
                                }
                            }
                        }
                    }
                    
                    Text("Accounts")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                    
                    LazyVGrid(columns: columnLayout){
                        ForEach(user.accounts){ account in
                            if !account.type == .cash {
                                Button{
                                    selectedAccount = account
                                } label: {
                                    AccountCardView(account: account, isSelected: selectedAccount == account)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("Select Account")
            .background(.background)
        }
                
    }
}

#Preview {
    SelectAccountView(selectedAccount: .constant(nil))
}

struct AccountCardView: View {
    
    var account: Account
    var isSelected: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 50)
                .foregroundStyle(account.color)
                .frame(height: 200)
            
            VStack{
                Spacer()
                ZStack{
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.white)
                    
                    Image(systemName: account.isCash ? "dollarsign" : "creditcard")
                        .foregroundStyle(account.color)
                        .font(.system(size: 35))
                }
                
                Spacer()
                Text(account.balance, format: .currency(code: account.currency.code))
                    .bold()
                    .foregroundStyle(.white)
                Text(account.name)
                    .foregroundStyle(.white)
                    .font(.footnote)
                
            }
            .padding()
        }
        .overlay(alignment: .topTrailing){
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .padding(18)
                    .foregroundStyle(.white)
            }
        }
    }
}
*/
