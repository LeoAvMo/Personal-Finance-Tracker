//
//  Category.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 26/08/25.
//

import SwiftUI
import SwiftData

@Model
class Category {
    var name: String
    var color: Color
    var iconName: String

    @Relationship(deleteRule: .nullify)
    var transactions: [Transaction] = []
    
    init(name: String = "", color: Color = .pink, iconName: String = "dollarsign") {
        self.name = name
        self.color = color
        self.iconName = iconName
    }
}
