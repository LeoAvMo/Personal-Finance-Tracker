//
//  TransferFundsView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 27/09/25.
//

import SwiftUI
import SwiftData

struct TransferFundsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Account.name) var accounts: [Account]
    @Query(sort: \Currency.name) var currencies: [Currency]
    
    @State private var sourceAccount: Account?
    @State private var destinationAccount: Account?
    @State private var amount: Double?
    
    @State private var showAlert: Bool = false
    @State private var alertItem: TrackerAlertItem?
    
    var body: some View {
        NavigationStack{
            Form {
                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                    /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                }
            }
            .navigationTitle(Text("Transfer Funds"))
        }
    }
}

#Preview {
    TransferFundsView()
}
