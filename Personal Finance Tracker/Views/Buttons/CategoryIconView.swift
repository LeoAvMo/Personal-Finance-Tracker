//
//  CategoryIconView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 20/08/25.
//

import SwiftUI

struct CategoryIconView: View {
    var category: Category?
    var showLabel: Bool = true
    var isSelected: Bool = true
    
    var body: some View {
        var displayedName: String {
            if category?.name.count ?? 9 > 8 {
                return category?.name.summarizeString(length: 5) ?? "Unknown"
            }
            else {
                return category?.name ?? "Unknown"
            }
        }
        VStack{
            ZStack(alignment: .center){
                if isSelected {
                    Circle()
                        .frame(width: 58, height: 58)
                        .foregroundStyle(category?.color ?? .pink)
                    Circle()
                        .frame(width: 54, height: 54)
                        .foregroundStyle(.background)
                }
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(category?.color ?? .pink)
                Image(systemName: category?.iconName ?? "dollarsign")
                    .foregroundColor(.white)
                    .font(.title)
                
            }
            //.overlay(CheckmarkIconView(),alignment: .topTrailing)
            if showLabel {
                // Put "..." string and only 5 characters for categories with a larger name of 8 chars
                Text(displayedName)
                    .font(.caption)
                    .foregroundStyle(category?.color ?? .pink)
            }
        }
            
    }
}

#Preview {
    CategoryIconView(category: Category())
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
