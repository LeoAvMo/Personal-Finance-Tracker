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
    let icons: [String] = ["dollarsign","bag.fill", "leaf.fill", "pencil", "ellipsis","cart.fill", "hammer.fill", "dumbbell.fill", "gift.fill","airplane","music.note","music.microphone","book.fill", "gamecontroller.fill", "arcade.stick.console.fill", "fork.knife", "birthday.cake.fill", "cup.and.saucer.fill", "coat.fill", "hat.cap.fill", "house.fill", "sofa.fill","cat.fill","dog.fill", "pawprint.fill","pills.fill", "car.fill", "keyboard.fill", "desktopcomputer", "laptopcomputer", "smartphone", "computermouse.fill", "bus.fill", "shippingbox.fill", "stethoscope", "bolt.fill", "drop.fill", "wifi" , "graduationcap.fill", "backpack.fill", "gearshape.2.fill", "basket.fill", "theatermasks.fill", "chevron.left.forwardslash.chevron.right", "popcorn.fill", "stroller.fill", "hanger", "exclamationmark.triangle.fill", "figure", "flame.fill", "paintbrush.pointed.fill", "heart.fill", "list.bullet.clipboard.fill", "ellipsis.curlybraces", "star.fill", "asterisk"]
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
                
                ScrollView {
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
                                    Circle()
                                        .aspectRatio(1.0, contentMode: ContentMode.fit)
                                        .foregroundStyle(allColors[index])
                                    Circle()
                                        .padding(2)
                                        .foregroundStyle(.background)
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
                                    Image(systemName: icons[index])
                                        .font(.system(size: 50))
                                        .aspectRatio(1.0, contentMode: ContentMode.fit)
                                        .foregroundStyle(.primary)
                                        .onTapGesture {categoryIcon = icons[index]}
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
        }
        
    }
}

#Preview {
    CreateCategoryView()
}
