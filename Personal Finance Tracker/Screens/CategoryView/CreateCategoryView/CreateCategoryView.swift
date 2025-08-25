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
    @State private var categoryIcon: String = "dollarsign"
    @State private var categoryColor: Color = .pink
    @State private var editSetting: EditSettings = .color
    @Binding var isPresented: Bool
    let columnLayout = Array(repeating: GridItem(), count: 4)
    let allColors: [Color] = [.pink, .red, .orange, .yellow, .green, .mint, .teal,.cyan, .blue, .indigo, .purple, .gray]
    let icons: [String] = [
        // 💰 Money & Commerce
        "dollarsign", "bag.fill", "cart.fill", "gift.fill", "shippingbox.fill", "basket.fill",
        
        // 🌿 Nature & Elements
        "leaf.fill", "flame.fill", "bolt.fill", "drop.fill",
        
        // ✏️ Tools & Work
        "pencil", "paintbrush.pointed.fill", "hammer.fill", "gearshape.2.fill",
        
        // 🎓 School & Learning
        "book.fill", "graduationcap.fill", "backpack.fill", "list.bullet.clipboard.fill",
        
        // 🎭 Entertainment & Arts
        "music.note", "music.microphone", "gamecontroller.fill", "arcade.stick.console.fill",
        "theatermasks.fill", "popcorn.fill", "star.fill",
        
        // 🍴 Food & Drink
        "fork.knife", "birthday.cake.fill", "cup.and.saucer.fill",
        
        // 👕 Clothing & Fashion
        "coat.fill", "hat.cap.fill", "hanger",
        
        // 🏠 Home & Living
        "house.fill", "sofa.fill",
        
        // 🐾 Animals & Pets
        "cat.fill", "dog.fill", "pawprint.fill",
        
        // 🩺 Health, Safety & Fitness
        "pills.fill", "stethoscope", "exclamationmark.triangle.fill", "heart.fill", "asterisk", "dumbbell.fill",
        
        // 🚗 Transportation
        "car.fill", "bus.fill", "airplane",
        
        // 💻 Technology
        "keyboard.fill", "desktopcomputer", "laptopcomputer", "smartphone", "computermouse.fill", "wifi",
        
        // 👶 Family & People
        "stroller.fill", "figure",
        
        // 🔣 Symbols & Misc
        "chevron.left.forwardslash.chevron.right", "ellipsis.curlybraces", "ellipsis"
    ]
    let rainbow = LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        NavigationStack{
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
                                    ColorPicker("Custom Color", selection: $categoryColor)
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
                                        if categoryColor == allColors[index] {
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
                                    .onTapGesture {categoryColor = allColors[index]}
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
                                    .onTapGesture {categoryIcon = icons[index]}
                                    .overlay(
                                        ZStack{
                                            Image(systemName: categoryIcon == icons[index] ? "checkmark.circle.fill" : "")
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
            .ignoresSafeArea(.all, edges: .horizontal)
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
