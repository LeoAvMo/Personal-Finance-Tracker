//
//  CategoryAlert.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 29/08/25.
//

import SwiftUI

struct TrackerAlertItem: Identifiable {
    var id: UUID = UUID()
    var alertTitle: Text
    var alertMessage: Text
    var alertDismissButton: Alert.Button
}

struct TrackerAlertContext {
    
    // MARK: CreateCategoryView Alerts
    static let categoryNameIsRequired: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create category"),
                                                                             alertMessage: Text("Category name is required."),
                                                                             alertDismissButton: .default(Text("OK")))
    
    // MARK: AddCurrencyView Alerts
    
    static let currencyHasNoName: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create currency"),
                                                                      alertMessage: Text("Currency should be named before adding. Please enter a name."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    static let currencyISDCodeIsIncorrect: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create currency"),
                                                                      alertMessage: Text("Enter a proper ISD code for the currency."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    static let currencyHasNoFlag: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create currency"),
                                                                      alertMessage: Text("Enter an emoji for the currency's flag."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    static let currencyAmountIsNotValid: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create currency"),
                                                                      alertMessage: Text("Give a proper amount to the currency. Amount should be more than 0 based in your main currency."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    // MARK: AddTransactionView Alerts
    
    //Transaction label is empty
    static let transactionLabelIsEmpty: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add transaction"),
                                                                              alertMessage: Text("Transaction should be named before adding. Please enter a name."),
                                                                              alertDismissButton: .default(Text("OK")))
    
    //Currency is nil
    static let currencyIsEmpty: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add transaction"),
                                                                    alertMessage: Text("There was an issue adding the transaction. Please verify a currency has been selected."),
                                                                    alertDismissButton: .default(Text("OK")))
    
    // amount is less or equal to zero
    static let invalidAmount: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add transaction"),
                                                                    alertMessage: Text("Please give a proper amount to the transaction. The amount will be added depending on the transaction type."),
                                                                    alertDismissButton: .default(Text("OK")))
    
    // Category is nil
    static let categoryIsEmpty: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add transaction"),
                                                                      alertMessage: Text("Please select a category for the transaction."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    // Account is nil
    static let accountIsEmpty: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add transaction"),
                                                                     alertMessage: Text("Please select a target account for the transaction."),
                                                                     alertDismissButton: .default(Text("OK")))
    
}
    
