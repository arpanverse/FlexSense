//
//  ConnectionScreen.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/8/25.
//

import SwiftUI

struct ConnectionScreen: View {
    @StateObject var manager = BLEManager.shared
    @State var statusString: String = "Unavailable"
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading, spacing: 6) {
                    Image(.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipped()
                        .padding(.bottom, 4)
                    Text("FlexSense")
                        .font(.system(size: 32, weight: .black))
                        .fontWidth(.expanded)
                    Text("Your wrist companion")
                        .font(.system(size: 15, weight: .medium))
                        .opacity(0.5)
                }
                HStack(spacing: 30) {
                    if manager.connectedPeripheral != nil {
                        Text("Connected")
                            .font(.system(size: 15, weight: .bold))
                            .fontWidth(.expanded)
                    } else {
                        Text("Not Connected")
                            .font(.system(size: 15, weight: .bold))
                            .fontWidth(.expanded)
                    }
                    if manager.connectedPeripheral != nil {
                        NavigationLink {
                            SessionScreen()
                        } label: {
                            Image(systemName: "arrow.right")
                                .fontWeight(.black)
                        }
                    }
                }
                .padding()
                .padding(.vertical, 4)
                .foregroundStyle(.background)
                .background(.primary)
                .padding(.top, 60)
                if manager.connectedPeripheral != nil {
                    NavigationLink {
                        FlexSettingsScreen()
                    } label: {
                        Text("FLex Settings")
                            .font(.system(size: 15, weight: .bold))
                            .fontWidth(.expanded)
                            .padding()
                            .padding(.vertical, 4)
                            .foregroundStyle(.background)
                            .background(.blue)
                    }

                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.bottom, 290)
            .sheet(isPresented: $manager.connectionSheetAppearance) {
                ConnectionSheet()
                    .foregroundStyle(.background)
                    .presentationDetents([.fraction(0.29)])
                    .presentationCornerRadius(0)
                    .presentationBackground(.primary)
            }
        }
    }
}

#Preview {
    ConnectionScreen()
}
