//
//  CreateCategoryView.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 21/08/25.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var iconName: String = "dollarsign"
    @State private var color: Color = .pink
    
    @State private var editSetting: EditSettings = .color
    @State private var showAlert: Bool = false
    @State private var categoryAlertItem: TrackerAlertItem?
    
    // Turn this to environment
    
    enum EditSettings : String, CaseIterable, Identifiable {
        case color, icon
        var id : Self { self }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                // Category Circle
                BigCategoryIconView(color: $color, iconName: $iconName)
                
                // Category Name Text Field
                TextField("Name", text: $name)
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
                            ColorSelectorView(color: $color)
                        case .icon:
                            IconSelectorView(iconName: $iconName)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: categoryAlertItem!.alertTitle,
                      message: categoryAlertItem!.alertMessage,
                      dismissButton: categoryAlertItem!.alertDismissButton)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Create Currency", systemImage: "checkmark", action: addCategory)
                }
            }
            .navigationTitle("Create Category")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(.background)
        
    }
    private func addCategory() {
        if name.isEmpty {
            categoryAlertItem = TrackerAlertContext.categoryNameIsRequired
            showAlert.toggle()
            return
        }
        withAnimation {
            let category = Category(name: name, colorHex: color.toHex() ?? "#FFFFFF", iconName: iconName)
            modelContext.insert(category)
            dismiss()
        }
    }
}

#Preview {
    AddCategoryView()
        .modelContainer(for: Category.self, inMemory: true)
}

struct BigCategoryIconView: View {
    @Binding var color: Color
    @Binding var iconName: String
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundStyle(color)
                .transition(.opacity)
                .frame(width: 200, height: 200)
                .glassEffect()
                .animation(.easeInOut(duration: 0.3), value: color)

            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundStyle(.white)
        }
    }
}

struct ColorSelectorView: View {
    @Binding var color: Color
    @State private var columnLayout = Array(repeating: GridItem(), count: 4)

    var body: some View {

        LazyVGrid(columns: columnLayout) {
            ForEach(allColors.indices, id: \.self){ index in
                Button{
                    color = allColors[index]
                } label:{
                    ZStack{
                        if color == allColors[index] {
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
    @Binding var iconName: String
    @Environment(\.colorScheme) var colorScheme
    @State private var columnLayout = Array(repeating: GridItem(), count: 4)
    
    var body: some View {
        LazyVGrid(columns: columnLayout) {
            ForEach(icons.indices, id: \.self){ index in
                Button {
                    iconName = icons[index]
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
                        Image(systemName: iconName == icons[index] ? "checkmark.circle.fill" : "")
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


