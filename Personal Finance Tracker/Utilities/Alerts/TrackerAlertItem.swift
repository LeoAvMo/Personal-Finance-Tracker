//
//  CategoryAlert.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 29/08/25.
//

import SwiftUI

enum AlertType {
    case cancel, delete
}

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
                                                                      alertMessage: Text("Currencies should be named before adding. Please enter a name."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    static let currencyISOCodeIsIncorrect: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create currency"),
                                                                               alertMessage: Text("Enter a proper ISO code for the currency."),
                                                                               alertDismissButton: .default(Text("OK")))
    
    static let currencyHasNoFlag: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create currency"),
                                                                      alertMessage: Text("Enter an emoji for the currency's flag."),
                                                                      alertDismissButton: .default(Text("OK")))
    
    static let currencyValueIsNotValid: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create currency"),
                                                                            alertMessage: Text("Give a proper amount to the currency. Amount should be more than 0 based in your main currency."),
                                                                            alertDismissButton: .default(Text("OK")))
    
    // MARK: AddAccountView Alerts
    
    static let accountHasNoName: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create account"),
                                                                     alertMessage: Text("Accounts should be named before adding. Please enter a name."),
                                                                     alertDismissButton: .default(Text("OK")))
    
    static let invalidAccountCurrency: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create account"),
                                                                           alertMessage: Text("Select a currency for the account."),
                                                                           alertDismissButton: .default(Text("OK")))
    
    static let invalidAccountBalance: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create account"),
                                                                          alertMessage: Text("Add an initial balance to the account of the corresponding currency."),
                                                                          alertDismissButton: .default(Text("OK")))
    
    static let invalidAccountMaxCredit: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create account"),
                                                                            alertMessage: Text("Add the max credit for the credit card account of the proper currency."),
                                                                            alertDismissButton: .default(Text("OK")))
    
    static let invalidAccountColor: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not create account"),
                                                                        alertMessage: Text("There was an issue adding the color for the account. Please try again."),
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
    
    // Insufficient Funds
    static let nonSufficientFunds: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Non-Sufficient Funds"),
                                                                       alertMessage: Text("There are not enough funds in the selected account for this transaction. Please, select another account"),
                                                                       alertDismissButton: .default(Text("OK")))
    
    // Currencies don't match
    static let currenciesDoNotMatch: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could Not Add Transaction"),
                                                                         alertMessage: Text("The selected currency and the selected account's currency do not match. Try selecting an account with the same currency."),
                                                                         alertDismissButton: .default(Text("OK")))
    
    // MARK: AccountCurrencySetupView Alerts
    
    static let currencyAlreadyCreated: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("You already added a currency"),
                                                                           alertMessage: Text("To continue, please add an account. You can edit the currency and the account later once you added them."),
                                                                           alertDismissButton: .default(Text("OK")))
    
    static let currencyNotCreated: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add account"),
                                                                       alertMessage: Text("Add a valid currency to create an account."),
                                                                       alertDismissButton: .default(Text("OK")))
    
    // MARK: TransactionsSetupView alerts
    
    static let categoryAlreadyCreated: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add category"),
                                                                           alertMessage: Text("It looks like there is already a category. Please try again later."),
                                                                           alertDismissButton: .default(Text("OK")))
    
    static let categoryNameAlreadyCreated: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not add category"),
                                                                               alertMessage: Text("There is already a category with that name. Try naming it a different way."),
                                                                               alertDismissButton: .default(Text("OK")))
    
    // MARK: CategoryView alerts
    static let categoriesCannotBeEmpty: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not delete category"),
                                                                            alertMessage: Text("There must be at least one category."),
                                                                            alertDismissButton: .default(Text("OK")))
    
    // MARK: TransactionListingView alerts
    static let negativeAccountBalance: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not delete transaction"),
                                                                           alertMessage: Text("Deleting this transaction would result in a negative account balance. Please add funds to your account before trying again."),
                                                                           alertDismissButton: .default(Text("OK")))
    
    // MARK: TransferFunds alerts
    static let differentCurrencies: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not transfer funds."),
                                                                        alertMessage: Text("The accounts should have the same currency to transfer funds. Try again with another account."),
                                                                        alertDismissButton: .default(Text("OK")))
    
    static let accountsAreEqual: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not transfer funds."),
                                                                        alertMessage: Text("Make sure to pick different accounts to transfer funds."),
                                                                        alertDismissButton: .default(Text("OK")))
    
    static let accountsNotPicked: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not transfer funds."),
                                                                        alertMessage: Text("Pick a source and destination account to transfer funds."),
                                                                        alertDismissButton: .default(Text("OK")))

    static let invalidTransferAmount: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not transfer funds."),
                                                                        alertMessage: Text("Insert a valid amount to transfer funds."),
                                                                        alertDismissButton: .default(Text("OK")))
    
    static let amountGreaterThanBalance: TrackerAlertItem = TrackerAlertItem(alertTitle: Text("Could not transfer funds."),
                                                                        alertMessage: Text("The amount to be transfered is greater than the source account's balance. Try again with a smaller amount."),
                                                                        alertDismissButton: .default(Text("OK")))
}
    
