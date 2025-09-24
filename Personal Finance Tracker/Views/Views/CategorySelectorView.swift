//
//  CategorySelectorView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 23/09/25.
//

import SwiftUI


struct CategorySelectorView: View {
    var categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            // Assuming CategoryIconView exists from your project
                            CategoryIconView(category: category, showLabel: true, isSelected: category == selectedCategory)
                        }
                    }
                }
            }
        }
    }
}
