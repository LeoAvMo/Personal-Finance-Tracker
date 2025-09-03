//
//  Currency.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 28/08/25.
//

import Foundation

struct Currency: Codable, Identifiable, Hashable, Equatable {
    var id: UUID = UUID()
    var name: String
    var code: String
    var flag: String
    var value: Double
}


