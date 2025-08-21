//
//  CreateCategoryView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 21/08/25.
//

import SwiftUI

struct CreateCategoryView: View {
    @State private var categoryName: String = ""
    @State private var categoryIcon: String = ""
    @State private var categoryColor: Color = .blue
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundStyle(categoryColor)
                    .frame(width: 250, height: 250)
                Image(systemName: "leaf.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                
                
            }
        }
    }
}

#Preview {
    CreateCategoryView()
}
