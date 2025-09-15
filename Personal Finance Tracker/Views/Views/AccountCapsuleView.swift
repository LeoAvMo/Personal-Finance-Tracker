//
//  AccountCapsuleView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 31/08/25.
//

import SwiftUI

struct AccountCapsuleView: View {
    public var account: Account
    public var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: account.type == .cash ? "dollarsign.circle" : "creditcard.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(account.color)
                .frame(width: 35, height: 35)
            VStack(alignment: .leading){
                Text("Balance:")
                    .foregroundStyle(account.color)
                    .fontWeight(.semibold)
                Text("\(account.name)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(account.balance, format: .currency(code: account.currency.code))
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.accent)
                    .font(.title)
            }
        }
        
    }
}
