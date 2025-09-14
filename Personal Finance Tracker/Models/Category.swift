//
//  Category.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 26/08/25.
//

import SwiftUI
import SwiftData

@Model
class Category: Hashable, Equatable {
    var name: String
    var colorHex: String
    var color: Color { Color(colorHex) }
    var iconName: String
    
    
    init(name: String = "", colorHex: String = "#000000", iconName: String = "dollarsign") {
        self.name = name
        self.colorHex = colorHex
        self.iconName = iconName
    }
}
