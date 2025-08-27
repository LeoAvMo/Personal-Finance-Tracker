//
//  CreateCategoryView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 21/08/25.
//

import SwiftUI



struct CreateCategoryView: View {
    @State private var placeholderCategory: Category = .init(id: UUID(), name: "", color: .pink, iconName: "dollarsign")
    @State private var editSetting: EditSettings = .color
    @Binding var isPresented: Bool
    
    enum EditSettings : String, CaseIterable, Identifiable {
        case color, icon
        var id : Self { self }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                
                // Category Circle
                BigCategoryIconView(placeholderCategory: $placeholderCategory)
                
                // Category Name Text Field
                TextField("Name", text: $placeholderCategory.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                // Picker to display icon or color selector
                Picker("", selection: $editSetting) {
                    Text("Color").tag(EditSettings.color)
                    Text("Icon").tag(EditSettings.icon)
                }
                .pickerStyle(.segmented)
                
                // Editor screen
                ScrollView(showsIndicators: false) {
                    switch editSetting {
                        case .color:
                            ColorSelectorView(placeholderCategory: $placeholderCategory)
                            
                        case .icon:
                            IconSelectorView(placeholderCategory: $placeholderCategory)
                    }
                }
                
            }
            .navigationTitle("Create Category")
        }
        .background(.background)
        .overlay(GeneralDismissButton(isShowingDetail: $isPresented), alignment: .topLeading)
        .overlay(AcceptButton(isPresented: $isPresented), alignment: .topTrailing)
    }
}

#Preview {
    CreateCategoryView(isPresented: .constant(true))
}

struct BigCategoryIconView: View {
    @Binding var placeholderCategory: Category
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .foregroundStyle(placeholderCategory.color)
                    .transition(.opacity)
                    .frame(width: 250, height: 250)
                    .glassEffect()
                

                if !placeholderCategory.iconName.isEmpty {
                    Image(systemName: placeholderCategory.iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse, options: .repeat(.continuous))
                        .id(placeholderCategory.iconName)
                        .transition(.opacity)
                }
            }
        }
    }
}

struct ColorSelectorView: View {
    @Binding var placeholderCategory: Category
    @State private var columnLayout = Array(repeating: GridItem(), count: 4)
    
    var body: some View {
        ZStack{
            Capsule()
                .foregroundStyle(rainbow)
                .glassEffect(.regular)
            VStack{
                ColorPicker("Custom Color", selection: $placeholderCategory.color)
                    .font(.title)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
            }
            .padding(.vertical)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        
        LazyVGrid(columns: columnLayout) {
            ForEach(allColors.indices, id: \.self){ index in
                Button{
                    placeholderCategory.color = allColors[index]
                } label:{
                    ZStack{
                        if placeholderCategory.color == allColors[index] {
                            Circle()
                                .aspectRatio(1.0, contentMode: ContentMode.fit)
                                .foregroundStyle(allColors[index])
                            Circle()
                                .padding(2)
                                .foregroundStyle(.background)
                        }
                        Circle()
                            .padding(4)
                            .foregroundStyle(allColors[index])
                    }
                }
            }
        }
        .padding(.horizontal)
        
    }
}

struct IconSelectorView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var columnLayout = Array(repeating: GridItem(), count: 4)
    @Binding var placeholderCategory: Category
    
    var body: some View {
        LazyVGrid(columns: columnLayout) {
            ForEach(icons.indices, id: \.self){ index in
                Button {
                    placeholderCategory.iconName = icons[index]
                } label: {
                    ZStack{
                        Image(systemName: icons[index])
                            .font(.system(size: 50))
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .frame(width: 80, height: 80)
                    }
                }
                .overlay(
                    ZStack{
                        Image(systemName: placeholderCategory.iconName == icons[index] ? "checkmark.circle.fill" : "")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.accent)
                    }
                    ,
                    alignment: .bottomTrailing)
                .padding(.vertical)
            }
        }
    }
}

