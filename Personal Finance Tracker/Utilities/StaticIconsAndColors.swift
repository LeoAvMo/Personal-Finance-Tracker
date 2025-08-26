//
//  StaticIconsAndColors.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 26/08/25.
//

import SwiftUI

// MARK: Colors

// All built-in SwiftUI Colors
let allColors: [Color] = [.pink, .red, .orange, .yellow, .green, .mint, .teal,.cyan, .blue, .indigo, .purple, .gray]

// Rainbow Gradient
let rainbow = LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)

// MARK: Symbols

// Built in SF symbols for creating new categories
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



