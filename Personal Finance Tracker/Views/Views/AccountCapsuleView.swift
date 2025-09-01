//
//  AccountCapsuleView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 31/08/25.
//

import SwiftUI

struct AccountCapsuleView: View {
    public var account: Account
    
    var body: some View {
        HStack {
            Image(systemName: account.isCash ? "dollarsign.circle" : "creditcard.fill")
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
        }
    }
}
