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
    var body: some View {
        NavigationStack{
            ScrollView {
           
                ForEach(accounts, id: \.self){ account in
                    Button{
                        selectedAccount = account
                    } label: {
                        AccountCapsuleView(account: account)
                    }
                }
                
            }
            .navigationBarTitle("Select Account")
        }
                
    }
}

#Preview {
    SelectAccountView(selectedAccount: .constant(nil))
}
