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
    @State private var totalBalance: Double = 0
    @State private var mockData = MockData()
    var body: some View {
        
        NavigationStack {
            Form{
                
                Section (header: Text("Total balance")) {
                    Picker(selection: .constant(1), label: Text("Picker")) {
                        Text("MXN 🇲🇽").tag(1)
                        Text("USD 🇺🇸").tag(2)
                        Text("EUR 🇪🇺").tag(3)
                    }
                    .pickerStyle(.segmented)
                    HStack{
                        Spacer()
                        Text("$\(totalBalance, specifier: "%.2f") \(selectedCurrency)")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    
                }

                Section(header: Text("Cash")) {
                    ForEach(MockData.mockAccounts) { acc in
                        if acc.isCash{
                            AccountCapsuleView(account: acc)
                        }
                    }
                }
                
                Section(header: Text("Cards")) {
                    ForEach(MockData.mockAccounts){ acc in
                        if !acc.isCash{
                            AccountCapsuleView(account: acc)
                        }
                    }
                }
            }
            .onAppear{
                totalBalance = cash + MockData.mockAccounts.reduce(0){ $0 + $1.balance}
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
                .foregroundStyle(Color("cashColor"))
                .frame(width: 35, height: 35)
            VStack(alignment: .leading){
                Text("Balance:")
                    .foregroundStyle(Color("cashColor"))
                    .fontWeight(.semibold)
            }
            Spacer()
            Text(cash, format: .currency(code: selectedCurrency))
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
    }
}




