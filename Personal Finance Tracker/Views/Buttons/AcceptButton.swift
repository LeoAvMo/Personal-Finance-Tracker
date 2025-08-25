//
//  AcceptButton.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 25/08/25.
//

import SwiftUI

struct AcceptButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            ZStack{
                Circle()
                    .foregroundStyle(.accent)
                    .frame(width: 45, height: 45)
                    
                Image(systemName: "checkmark")
                    .fontWeight(.semibold)
                    .frame(width: 45, height: 45)
                    .foregroundStyle(.white)
            }
            .glassEffect(.regular.tint(.accent.opacity(0.9)).interactive())
        }
        .padding()
    }
}

#Preview {
    AcceptButton(isPresented: .constant(true))
}
