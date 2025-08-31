//
//  Category.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 26/08/25.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    var id: UUID
    var name: String
    var color: Color
    var iconName: String
}
