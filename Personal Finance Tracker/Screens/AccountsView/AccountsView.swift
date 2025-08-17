//
//  AccountsView.swift
//  FinanceTracker
//
//  Created by Leo A.Molina on 29/07/25.
//

import SwiftUI

struct AccountsView: View {
    @State private var selectedCurrency: String = "MXN"
    @State private var cash: Double = 1000
    @State private var mockData = MockData()
    @State private var totalBalance: Double = 0
    var body: some View {
        
        NavigationStack {
            Form{
                
                HStack{
                    Text("Total Balance:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("")) {
                        Text("MXN").tag(1)
                        Text("EUR").tag(2)
                        Text("USD").tag(3)
                    }
                    .pickerStyle(.automatic)
                }
                
                HStack{
                    Spacer()
                    Text("$\(totalBalance, specifier: "%.2f") \(selectedCurrency)")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                
                Section(header: Text("Cash")) {
                    CashCapsuleView(cash: cash, selectedCurrency: selectedCurrency)
                }
                
                Section(header: Text("Cards")) {
                    ForEach(mockData.mockAccounts){ acc in
                        AccountCapsuleView(account: acc, selectedCurrency: selectedCurrency)
                    }
                    

                }
            }
            .onAppear{
                totalBalance = cash + mockData.mockAccounts.reduce(0){ $0 + $1.balance}
            }
            .navigationTitle("Accounts")
        }
        
    }
}

#Preview {
    AccountsView()
}

struct CashCapsuleView: View {
    public var cash: Double
    public var selectedCurrency: String
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.ring")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.green)
                .frame(width: 35, height: 35)
            VStack(alignment: .leading){
                Text("Balance:")
                    .foregroundStyle(.green)
                    .fontWeight(.semibold)
            }
            Spacer()
            Text("$\(cash, specifier: "%.2f") \(selectedCurrency)")
                .fontWeight(.semibold)
        }
    }
}

struct AccountCapsuleView: View {
    public var account: Account
    public var selectedCurrency: String
    var body: some View {
        HStack {
            Image(systemName: "creditcard.fill")
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
            Text("$\(account.balance, specifier: "%.2f") \(selectedCurrency)")
                .fontWeight(.semibold)
        }
    }
}


