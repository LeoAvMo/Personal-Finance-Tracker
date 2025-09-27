//
//  AccountDescriptionListView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 21/09/25.
//

import SwiftUI

struct AccountDescriptionListView: View {
    @State public var account: Account
    public var transactionAmount: Double?
    public var transactionType: TransactionType
    public var isSelected: Bool
    
    var isAffordable: Bool {
        if transactionType == .income {
            return true
        }
        
        if transactionAmount ?? -1 > account.balance {
            return false
        }
        return true
    }
    
    var balanceColor: Color {
        isAffordable ? .green : .red
    }
    var body: some View {
        
        List{
            HStack{
                Image(systemName: account.type == .cash ? "dollarsign.circle" : "creditcard.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(account.color)
                    .frame(width: 35, height: 35)
                VStack(alignment: .leading){
                    Text("\(account.name)")
                        .foregroundStyle(account.color)
                        .fontWeight(.semibold)
                    Text("\(account.type.rawValue.capitalized)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text(account.balance, format: .currency(code: account.currency.code))
                    .fontWeight(.semibold)
                    .foregroundStyle(balanceColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(.accent.opacity(0))
                            .strokeBorder(isSelected ? balanceColor : .clear, lineWidth: 2.5)
                            .animation(.easeInOut(duration: 0.2), value: isSelected)
                    )
            }
        }
    }
}

#Preview {
    AccountDescriptionListView(account: Account(), transactionAmount: 0, transactionType: .expense, isSelected: true)
        
}

