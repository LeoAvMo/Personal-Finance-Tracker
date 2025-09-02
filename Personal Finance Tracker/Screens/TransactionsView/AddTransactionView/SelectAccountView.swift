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
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Cash")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                    
                    LazyVGrid(columns: columnLayout){
                        ZStack{
                            Capsule()
                                .foregroundStyle(.red)
                            Circle()
                                .frame(width: 40, height: 40)
                        }
                    }
                    Text("Accounts")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                    
                    Text("Credit Cards")
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
