
//
//  CategoryIconView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 20/08/25.
//

import SwiftUI

struct AddButton: View {
    
    var showLabel: Bool = true
    
    
    var body: some View {
        
        VStack{
            ZStack(alignment: .center){
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.accent)
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .glassEffect(.regular.interactive())
            //.overlay(CheckmarkIconView(),alignment: .topTrailing)
            if showLabel {
                // Put "..." string and only 5 characters for categories with a larger name of 8 chars
                Text("Add")
                    .font(.caption)
                    .foregroundStyle(.accent)
            }
        }
            
    }
}

#Preview {
    AddButton(showLabel: true)
}

/*
struct CheckmarkIconView: View {
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.green)
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.caption2)
        }
        .offset(x: 4, y: -5)
    }
}
*/
