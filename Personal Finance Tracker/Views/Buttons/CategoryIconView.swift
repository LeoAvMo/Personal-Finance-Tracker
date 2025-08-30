//
//  CategoryIconView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 20/08/25.
//

import SwiftUI

struct CategoryIconView: View {
    var category: Category
    var showLabel: Bool = true
    var isSelected: Bool = true
    
    var body: some View {
        VStack{
            ZStack(alignment: .center){
                if isSelected {
                    Circle()
                        .frame(width: 58, height: 58)
                        .foregroundStyle(category.color)
                    Circle()
                        .frame(width: 54, height: 54)
                        .foregroundStyle(.background)
                }
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(category.color)
                Image(systemName: category.iconName)
                    .foregroundColor(.white)
                    .font(.title)
                
            }
            //.overlay(CheckmarkIconView(),alignment: .topTrailing)
            if showLabel {
                // Put "..." string and only 5 characters for categories with a larger name of 8 chars
                Text(category.name)
                    .font(.caption)
                    .foregroundStyle(category.color)
            }
        }
            
    }
}

#Preview {
    CategoryIconView(category: Category(id: UUID(), name: "Expenses", color: .green, iconName: "dollarsign"), showLabel: true, isSelected: true)
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
