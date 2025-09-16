//
//  Currency.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 28/08/25.
//

import SwiftUI
import SwiftData

// TODO: make code UNIQUE
@Model
class Currency: Hashable, Equatable{
    var name: String
    var code: String
    var flag: String
    var value: Double
    

    init(name: String = "US Dollar", code: String = "USD", flag: String = "🇺🇸", value: Double = 1.0) {
        self.name = name
        self.code = code
        self.flag = flag
        self.value = value
    }
}
