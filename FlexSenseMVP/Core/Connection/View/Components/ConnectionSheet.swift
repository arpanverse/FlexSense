//
//  ConnectionSheet.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/8/25.
//

import SwiftUI

struct ConnectionSheet: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            Text("FlexSense is \navailable nearby.")
                .font(.system(size: 17, weight: .semibold))
                .fontWidth(.expanded)
            .padding(.leading, 28)
            Text("Connect")
                .font(.system(size: 17, weight: .black))
                .fontWidth(.expanded)
                .padding()
                .padding(.vertical, 2)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.black)
                .background(.background)
                .padding()
                .padding(.horizontal)
            
        }
        .padding(.top, 50)
    }
}

#Preview {
    ConnectionSheet()
}
