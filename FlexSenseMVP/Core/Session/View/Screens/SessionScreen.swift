//
//  SessionScreen.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/8/25.
//

import SwiftUI

struct SessionScreen: View {
    @StateObject var manager = BLEManager.shared
    @StateObject var vm = SessionViewModel.shared
    let column: [GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: 4),
        GridItem(.flexible(minimum: 100), spacing: 4),
    ]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                //accleration
                VStack(alignment: .leading, spacing: 12) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundStyle(.gray.opacity(0.2))
                        Rectangle()
                            .foregroundStyle(.blue)
                            .frame(width: vm.liveAcclScale)
                    }
                    .frame(height: 50)
                    HStack {
                        Text("Avg  \(String(format: "%.1f", vm.avgAccl))")
                        Spacer()
                        Text("Live  \(String(format: "%.1f", vm.accl))")
                            .foregroundStyle(.blue)
                    }
                    .font(.system(size: 17, weight: .black))
                    .fontWidth(.expanded)
                }
                .padding(.top, 6)
                .padding(.bottom, 45)
                //flex-graphs
                FlexGraph(position: "Upper", flexValue: vm.ScaledFlex1, array: vm.flex1Array, count: vm.count)
                    .padding(.bottom, 30)
                FlexGraph(position: "Lower", flexValue: vm.ScaledFlex2, array: vm.flex2Array, count: vm.count)
                    .padding(.bottom, 21)
                //phases-tab
                VStack(alignment: .leading, spacing: 17) {
                    Text("Live Phases")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                    LazyVGrid(columns: column, spacing: 4) {
                        PhaseTabView(text: "Ready", isActive: vm.activePhase == "Ready" ? true : false)
                        PhaseTabView(text: "Swing", isActive: vm.activePhase == "Swing" ? true : false)
                        PhaseTabView(text: "Follow through", isActive: vm.activePhase == "Follow through" ? true : false)
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
                            StatusTabView(status: "Up \nFlex", value: vm.readyUF)
                            StatusTabView(status: "Low Flex", value: vm.readyLF)
                            StatusTabView(status: "Critical", value: vm.readyCF)
                            StatusTabView(status: "Accl", value: vm.readyACC)
                        }
                    }
                    //swing
                    VStack(alignment: .leading, spacing: 17) {
                        Text("Swing")
                            .font(.system(size: 17, weight: .black))
                            .fontWidth(.expanded)
                        HStack(spacing: 4) {
                            StatusTabView(status: "Up \nFlex", value: vm.swingUF)
                            StatusTabView(status: "Low Flex", value: vm.swingLF)
                            StatusTabView(status: "Critical", value: vm.swingCF)
                            StatusTabView(status: "Accl", value: vm.swingACC)
                        }
                    }
                    //Follow
                    VStack(alignment: .leading, spacing: 17) {
                        Text("Follow")
                            .font(.system(size: 17, weight: .black))
                            .fontWidth(.expanded)
                        HStack(spacing: 4) {
                            StatusTabView(status: "Up \nFlex", value: vm.followUF)
                            StatusTabView(status: "Low Flex", value: vm.followLF)
                            StatusTabView(status: "Critical", value: vm.followCF)
                            StatusTabView(status: "Accl", value: vm.followACC)
                        }
                    }
                }
                .padding(.vertical, 28)
            }
            .padding(.horizontal)
            .onChange(of: manager.latestSensorData) { _, _ in
                vm.SplitString(manager.latestSensorData)
                vm.calculateAcclScale()
                vm.getFlex()
                vm.extractActivePhase()
            }
            .onChange(of: vm.activePhase) { _, new in
                if new == "Ready" {
                    vm.GetReadyAnalytics()
                } else if new == "Swing" {
                    vm.GetSwingAnalytics()
                } else if new == "Follow through" {
                    vm.GetFollowAnalytics()
                }
            }
        }
        .navigationTitle("Session")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SessionScreen()
}
