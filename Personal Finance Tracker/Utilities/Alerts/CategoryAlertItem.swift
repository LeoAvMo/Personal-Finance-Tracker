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
    
    // MARK: CreateCategoryView Alerts
    static let categoryNameIsRequired: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not create category"),
                                                                             alertMessage: Text("Category name is required."),
                                                                             alertDismissButton: .default(Text("OK")))
    
    // MARK: AddTransactionView Alerts
    
    //Transaction label is empty
    static let transactionLabelIsEmpty: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not add transaction"),
                                                                              alertMessage: Text("Transaction should be named before adding. Please enter a name."),
                                                                              alertDismissButton: .default(Text("OK")))
    
    // Transaction type is not selected
    static let transactionTypeNotSelected: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not add transaction"),
                                                                                 alertMessage: Text("Transaction cannot be added without a type. Please select a transaction type."),
                                                                                 alertDismissButton: .default(Text("OK")))
    //Currency is nil
    static let currencyIsEmpty: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not add transaction"),
                                                                    alertMessage: Text("There was an issue adding the transaction. Please verify a currency has been selected."),
                                                                    alertDismissButton: .default(Text("OK")))
    
    // amount is less or equal to zero
    static let invalidAmount: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not add transaction"),
                                                                    alertMessage: Text("Please give a proper amount to the transaction. The amount will be added depending on the transaction type."),
                                                                    alertDismissButton: .default(Text("OK")))
    
    // Date is nil
    static let dateIsEmpty: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not add transaction"),
                                                                  alertMessage: Text("Please select a proper date for the transaction."),
                                                                  alertDismissButton: .default(Text("OK")))
    
    // Category is nil
    static let categoryIsEmpty: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not add transaction"),
                                                                      alertMessage: Text("Please select a category for the transaction."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    // Account is nil
    static let accountIsEmpty: CategoryAlertItem = CategoryAlertItem(alertTitle: Text("Could not add transaction"),
                                                                     alertMessage: Text("Please select a target account for the transaction."),
                                                                     alertDismissButton: .default(Text("OK")))
    
}
    
