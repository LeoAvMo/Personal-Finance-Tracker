//
//  Personal_Finance_TrackerApp.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 16/08/25.
///Users/leoavmo/Documents/Coding/Swift/FinanceTrackerTest/FinanceTrackerTest/LoadUserView.swift

import SwiftUI
import SwiftData

@main
struct Personal_Finance_TrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PFTUser.self, Account.self, Transaction.self, Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LoadUserView()
        }
        .modelContainer(sharedModelContainer)
    }
}
