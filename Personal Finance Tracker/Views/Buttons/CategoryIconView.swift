//
//  CategoryIconView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 20/08/25.
//

import SwiftUI

struct CategoryIconView: View {
    var categoryName: String
    var iconColor: Color
    var iconImageName: String
    var showLabel: Bool = true
    var isSelected: Bool = true
    
    var body: some View {
        VStack{
            ZStack(alignment: .center){
                if isSelected {
                    Circle()
                        .frame(width: 58, height: 58)
                        .foregroundStyle(iconColor)
                    Circle()
                        .frame(width: 54, height: 54)
                        .foregroundStyle(.background)
                }
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(iconColor)
                Image(systemName: iconImageName)
                    .foregroundColor(.white)
                    .font(.title)
                
            }
            //.overlay(CheckmarkIconView(),alignment: .topTrailing)
            if showLabel {
                Text(categoryName)
                    .font(.caption)
                    .foregroundStyle(iconColor)
            }
        }
            
    }
}

#Preview {
    CategoryIconView(categoryName: "Food", iconColor: .orange, iconImageName: "fork.knife", showLabel: true, isSelected: true)
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
