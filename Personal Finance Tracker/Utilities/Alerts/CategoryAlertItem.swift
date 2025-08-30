//
//  CategoryAlert.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 29/08/25.
//

import SwiftUI

struct CategoryAlertItem: Identifiable {
    var id: UUID = UUID()
    var alertTitle: Text
    var alertMessage: Text
    var alertDismissButton: Alert.Button
}

struct AlertContext {
    static let categoryNameIsRequired: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not create category"),
                                                                             alertMessage: Text("Category name is required"),
                                                                             alertDismissButton: .default(Text("OK")))
}
