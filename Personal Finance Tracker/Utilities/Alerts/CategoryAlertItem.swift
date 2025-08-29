//
//  CategoryAlert.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 29/08/25.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id: UUID = UUID()
    var title: Text
    var message: Text
    var dismissButton: Text
}

struct AlertContext {
    static let categoryNameIsRequired: AlertItem = AlertItem(title: Text("Could not create category"),
                                                             message: Text("Category name is required"),
                                                             dismissButton: Text("OK"))
}
