//
//  Account.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 17/08/25.
//

import SwiftUI

struct Account: Identifiable, Hashable, Equatable {
    var id: UUID = UUID()
    var name: String
    var balance: Double
    var color: Color
    var currency: Currency
    var isCash: Bool
}


