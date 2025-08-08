//
//  SwiftUIView.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/9/25.
//

import SwiftUI
import Charts

struct FlexGraph: View {
    var position: String
    var flexValue: Double
    var array: [FlexPair]
    var count: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("\(position) Flex")
                    .opacity(0.5)
                Text("\(String(format: "%.1f", flexValue))º")
            }
            .font(.system(size: 17, weight: .black))
            .fontWidth(.expanded)
            .foregroundStyle(.black)
            Chart {
                ForEach(array) { pair in
                    PointMark(x: .value("", String(pair.count)), y: .value("", pair.flex))
                        .foregroundStyle(pair.flex > 0 ? .blue : .clear)
                    LineMark(x: .value("", String(pair.count)), y: .value("", pair.flex))
                        .foregroundStyle(.blue)
                    AreaMark(x: .value("", String(pair.count)), y: .value("", pair.flex))
                        .foregroundStyle(LinearGradient(colors: [.blue.opacity(0.3), .clear], startPoint: .top, endPoint: .bottom))
                }
            }
            .chartXAxis(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 362)
        .padding(.bottom)
    }
}

#Preview {
    FlexGraph(position: "", flexValue: 0, array: [], count: 0)
}
