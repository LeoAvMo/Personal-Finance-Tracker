//
//  Category.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 26/08/25.
//

import SwiftUI
import SwiftData

//TODO: Make category name unique

@Model
class Category: Hashable, Equatable {
    var name: String
    var colorHex: String
    var color: Color {
            get {
                Color(hex: colorHex) ?? .white
            }
            set {
                
                colorHex = newValue.toHex() ?? "#FFFFFF"
            }
        }
    var iconName: String
    
    
    init(name: String = "", colorHex: String = "#FFFFFF", iconName: String = "dollarsign") {
        self.name = name
        self.colorHex = colorHex
        self.iconName = iconName
    }
}
