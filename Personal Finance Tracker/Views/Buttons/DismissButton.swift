//
//  DismissButton.swift
//  Personal Finance Tracker
//
//  Created by Leo A.Molina on 25/08/25.
//

import SwiftUI

struct GeneralDismissButton: View {
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        Button{
            isShowingDetail = false
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(.accent)
                .frame(width: 20, height: 30)
        }
        .buttonStyle(.glass)
        .padding()
    }
}

#Preview {
    GeneralDismissButton(isShowingDetail: .constant(true))
}
