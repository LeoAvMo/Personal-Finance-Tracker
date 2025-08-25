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
                        CategoryIconView(categoryName: "Shopping", iconColor: .blue, iconImageName: "bag.fill", showLabel: false, isSelected: false)
                        VStack(alignment: .leading){
                            Text("Magic Keyboard")
                                .font(.title2)
                            Text("10/10/2025")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Divider()
                            Text("Débito Santander")
                                .font(.body)
                                .foregroundStyle(.primary)
                            HStack{
                                Text("-$1,000,599.00 MXN")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.red)
                                Image(systemName: "chart.line.downtrend.xyaxis")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.red)
                            }

                        }
                        .padding(.leading)
                    }
                }
            }
            .sheet(isPresented: $showAddTransactionView){
                AddTransactionView(isShowingAddTransactionView: $showAddTransactionView)
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
