//
//  SwiftUIView.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/9/25.
//

import SwiftUI

struct PhaseTabView: View {
    var text: String
    var isActive: Bool
    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .black))
            .fontWidth(.expanded)
            .padding(.vertical, 21)
            .frame(maxWidth: .infinity)
            .foregroundStyle(isActive ? .white : .primary)
            .background(isActive ? .blue : .gray.opacity(0.2))
    }
}

#Preview {
    PhaseTabView(text: "", isActive: false)
}
