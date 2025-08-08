//
//  SwiftUIView.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/9/25.
//

import SwiftUI

struct StatusTabView: View {
    var status: String
    var value: Double
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(status)
                .font(.system(size: 11, weight: .black))
                .opacity(0.6)
            Text(String(format: "%.1f", value))
                .font(.system(size: 17, weight: .black))
        }
        .fontWidth(.expanded)
        .padding()
        .padding(.vertical, 9)
        .frame(height: 120, alignment: .bottom)
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.1))
    }
}

#Preview {
    StatusTabView(status: "", value: 0)
}
