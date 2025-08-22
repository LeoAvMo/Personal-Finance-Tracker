//
//  CreateCategoryView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 21/08/25.
//

import SwiftUI

enum EditSettings : String, CaseIterable, Identifiable {
    case color, icon
    var id : Self { self }
}

struct CreateCategoryView: View {
    @State private var categoryName: String = ""
    @State private var categoryIcon: String = "leaf.fill"
    @State private var categoryColor: Color = .blue
    @State private var editSetting: EditSettings = .color
    let columnLayout = Array(repeating: GridItem(), count: 4)
    let allColors: [Color] = [.pink, .red, .orange, .yellow, .green, .mint, .teal,.cyan, .blue, .indigo, .purple, .gray]
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            ZStack{
                Circle()
                    .foregroundStyle(categoryColor)
                    .frame(width: 250, height: 250)
                    .glassEffect()
                Image(systemName: categoryIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 140)
                    .foregroundStyle(.white)
            }
            
            TextField("Name", text: $categoryName)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Picker(selection: $editSetting, label: Text("Picker")) {
                Text("Color").tag(EditSettings.color)
                Text("Icon").tag(EditSettings.icon)
            }
            .pickerStyle(.segmented)
            
            ScrollView {
                switch editSetting {
                    case .color:
                        Button("Custom Color") {
                            
                        }
                        .font(.title)
                        .fontWeight(.semibold)
                        .buttonStyle(.glass)
                        
                        LazyVGrid(columns: columnLayout) {
                            ForEach(allColors.indices, id: \.self){ index in
                                Circle()
                                    .aspectRatio(1.0, contentMode: ContentMode.fit)
                                    .foregroundStyle(allColors[index])
                                    .onTapGesture {categoryColor = allColors[index]}
                            }
                        }
                        
                    case .icon:
                        Text("Images")
                }
            }
            
            
        }
        .padding()
        .navigationTitle("Create Category")
    }
}

#Preview {
    CreateCategoryView()
}
