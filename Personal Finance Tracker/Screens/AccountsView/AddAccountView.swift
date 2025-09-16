//
//  AddAccountView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 15/09/25.
//

import SwiftUI

struct AddAccountView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var name: String = ""
    @State private var balance: Double = 0
    @State private var color: Color = .green
    @State private var accountType: AccountType = .cash
    @State private var currency: Currency?
    @State private var maxCredit: Double?
    var body: some View {
        NavigationStack{
            Form {
                
            }
            .navigationTitle(Text("Add Account"))
        }
        
    }
}

#Preview {
    AddAccountView()
}
