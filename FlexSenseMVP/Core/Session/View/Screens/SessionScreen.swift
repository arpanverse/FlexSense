//
//  SessionScreen.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/8/25.
//

import SwiftUI

struct SessionScreen: View {
    let column: [GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: 4),
        GridItem(.flexible(minimum: 100), spacing: 4),
    ]
    var body: some View {
        ScrollView {
            VStack {
                //accleration
                VStack(alignment: .leading, spacing: 12) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundStyle(.gray.opacity(0.2))
                        Rectangle()
                            .foregroundStyle(.blue)
                            .frame(width: 30)
                    }
                    .frame(height: 50)
                    HStack {
                        Text("Avg  \(String(format: "%.1f", 4.5))")
                        Spacer()
                        Text("Live  \(String(format: "%.1f", 2.5))")
                            .foregroundStyle(.blue)
                    }
                    .font(.system(size: 17, weight: .black))
                    .fontWidth(.expanded)
                }
                .padding(.bottom, 45)
                //flex-graphs
                FlexGraph(position: "Upper", flexValue: 0.5, array: [], count: 0)
                    .padding(.bottom, 30)
                FlexGraph(position: "Lower", flexValue: 0.3, array: [], count: 0)
                    .padding(.bottom, 21)
                //phases-tab
                VStack(alignment: .leading, spacing: 17) {
                    Text("Live Phases")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                    LazyVGrid(columns: column, spacing: 4) {
                        PhaseTabView(text: "Ready", isActive: false)
                        PhaseTabView(text: "Swing", isActive: true)
                        PhaseTabView(text: "Follow through", isActive: false)
                    }
                }
                .padding(.vertical, 28)
                //phase-status
                VStack(alignment: .leading, spacing: 24) {
                    //ready
                    VStack(alignment: .leading, spacing: 17) {
                        Text("Ready")
                            .font(.system(size: 17, weight: .black))
                            .fontWidth(.expanded)
                        HStack(spacing: 4) {
                            StatusTabView(status: "Up \nFlex", value: 1.3)
                            StatusTabView(status: "Down Flex", value: 2.2)
                            StatusTabView(status: "Critical", value: 5)
                            StatusTabView(status: "Accl", value: 2.5)
                        }
                    }
                    //swing
                    VStack(alignment: .leading, spacing: 17) {
                        Text("Swing")
                            .font(.system(size: 17, weight: .black))
                            .fontWidth(.expanded)
                        HStack(spacing: 4) {
                            StatusTabView(status: "Up \nFlex", value: 1.3)
                            StatusTabView(status: "Down Flex", value: 2.2)
                            StatusTabView(status: "Critical", value: 5)
                            StatusTabView(status: "Accl", value: 2.5)
                        }
                    }
                    //Follow
                    VStack(alignment: .leading, spacing: 17) {
                        Text("Follow")
                            .font(.system(size: 17, weight: .black))
                            .fontWidth(.expanded)
                        HStack(spacing: 4) {
                            StatusTabView(status: "Up \nFlex", value: 1.3)
                            StatusTabView(status: "Down Flex", value: 2.2)
                            StatusTabView(status: "Critical", value: 5)
                            StatusTabView(status: "Accl", value: 2.5)
                        }
                    }
                }
                .padding(.vertical, 28)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Session")
    }
}

#Preview {
    SessionScreen()
}
