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
    @State private var columnLayout = Array(repeating: GridItem(), count: 4)
    @Binding var isPresented: Bool
    
    enum EditSettings : String, CaseIterable, Identifiable {
        case color, icon
        var id : Self { self }
    }
    
    
    
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                
                Spacer()
                ZStack{
                    Circle()
                        .foregroundStyle(placeholderCategory.color)
                        .frame(width: 250, height: 250)
                        .glassEffect()
                    Image(systemName: placeholderCategory.iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .foregroundStyle(.white)
                }
                
                TextField("Name", text: $placeholderCategory.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Spacer()
                Picker(selection: $editSetting, label: Text("Picker")) {
                    Text("Color").tag(EditSettings.color)
                    Text("Icon").tag(EditSettings.icon)
                }
                .pickerStyle(.segmented)
                .foregroundStyle(.accent)
                
                ScrollView(showsIndicators: false) {
                    HStack{Spacer()}
                    switch editSetting {
                        case .color:
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
                            
                            
                            LazyVGrid(columns: columnLayout) {
                                ForEach(allColors.indices, id: \.self){ index in
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
                                    .onTapGesture {placeholderCategory.color = allColors[index]}
                                }
                            }
                            
                        case .icon:
                            LazyVGrid(columns: columnLayout) {
                                ForEach(icons.indices, id: \.self){ index in
                                    ZStack{
                                        
                                        Image(systemName: icons[index])
                                            .font(.system(size: 50))
                                            .foregroundStyle(.primary)
                                            .frame(width: 80, height: 80)
                                    }
                                    .onTapGesture {placeholderCategory.iconName = icons[index]}
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
            }
            
            .padding()
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle("Create Category")
            .background(.background)
            
        }
        .overlay(GeneralDismissButton(isShowingDetail: $isPresented), alignment: .topLeading)
        .overlay(AcceptButton(isPresented: $isPresented), alignment: .topTrailing)
    }
}

#Preview {
    CreateCategoryView(isPresented: .constant(true))
}

