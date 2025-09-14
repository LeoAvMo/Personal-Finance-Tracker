//
//  LoadUserView.swift
//  FinanceTrackerTest
//
//  Created by Leo A.Molina on 12/09/25.
//
/*
import SwiftUI
import SwiftData

struct LoadUserView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var users: [PFTUser]
    
    var body: some View {
        if let user = users.first {
           FTTabView()
        } else {
            ProgressView()
                .onAppear {
                    createUser()
                }
        }
    }
    
    private func createUser() {
        let user = PFTUser(username: "User")
        modelContext.insert(user)
    }
}

#Preview {
    LoadUserView()
}
*/
