//
//  SelectAccountView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 31/08/25.
//

import SwiftUI

struct SelectAccountView: View {
    @Binding var selectedAccount: Account?
    @State private var accounts: [Account] = MockData.mockAccounts  //Turn this to environment variable
    @State private var columnLayout = Array(repeating: GridItem(), count: 2)
    
    var mockAccount: Account = MockData.mockAccount
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Cash")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                    
                    LazyVGrid(columns: columnLayout){
                        
                        Button {
                            
                        } label : {
                            ZStack{
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundStyle(mockAccount.color)
                                    .frame(height: 200)
                                
                                VStack{
                                    Spacer()
                                    ZStack{
                                        Circle()
                                            .frame(width: 60, height: 60)
                                            .foregroundStyle(.white)
                                        
                                        Image(systemName: "dollarsign")
                                            .foregroundStyle(mockAccount.color)
                                            .font(.system(size: 35))
                                    }
                                    
                                    Spacer()
                                    Text(mockAccount.balance, format: .currency(code: mockAccount.currency.code))
                                        .bold()
                                        .foregroundStyle(.white)
                                    Text(mockAccount.name)
                                        .foregroundStyle(.white)
                                        .font(.footnote)
                                    
                                }
                                .padding()
                            }
                            
                        }
                        
                        
                        
                    }
                    Text("Accounts")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                    
                }
                
                ForEach(accounts, id: \.self){ account in
                    Button{
                        selectedAccount = account
                    } label: {
                        AccountCapsuleView(account: account)
                    }
                }
                
            }
            .padding(.horizontal)
            .navigationBarTitle("Select Account")
        }
                
    }
}

#Preview {
    SelectAccountView(selectedAccount: .constant(nil))
}

struct AccountCardView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
