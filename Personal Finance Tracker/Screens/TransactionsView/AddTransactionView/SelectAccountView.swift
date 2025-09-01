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
            Form{
                Section("My Accounts"){
                    
                }
            }
            .navigationBarTitle("Select Account")
        }
                
    }
}

#Preview {
    SelectAccountView(selectedAccount: .constant(nil))
}
