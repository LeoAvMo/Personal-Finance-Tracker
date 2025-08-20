//
//  TransactionsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI

struct TransactionsView: View {
    @State private var showAddTransactionView: Bool = false
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Total transactions")){
                    
                }
                Section(header: Text("Transactions")){
                    HStack{
                        Image(systemName: "leaf")
                        Text("Example transaction")
                    }
                }
            }
            .sheet(isPresented: $showAddTransactionView){
                AddTransactionView()
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        showAddTransactionView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundStyle(.accent)
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    TransactionsView()
}
