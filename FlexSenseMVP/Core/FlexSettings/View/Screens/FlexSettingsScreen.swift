//
//  FlexSettingsScreen.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/10/25.
//

import SwiftUI
import SwiftData

struct FlexSettingsScreen: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @StateObject var vm = FlexSettingViewModel.shared
    @StateObject var manager = BLEManager.shared
    @State var isUpperFlexUpdating: Bool = false
    @State var isLowerFlexUpdating: Bool = false
    
    var user: User? {
        users.last
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipped()
                .padding(.bottom, 4)
            Text("Set Critical Flex \nValues ")
                .font(.system(size: 23, weight: .black))
                .fontWidth(.expanded)
            Text("Personalize according to your \ncomfort level.")
                .font(.system(size: 15, weight: .medium))
                .opacity(0.5)
                .padding(.top, 4)
            Spacer()
            HStack(spacing: 17) {
                //upper-Flex
                VStack(spacing: 12) {
                    Text("Upper")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                        .padding(.bottom)
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .frame(width: 65, height: 280)
                            .opacity(0.2)
                        Rectangle()
                            .foregroundStyle(.blue)
                            .frame(width: 65, height: isUpperFlexUpdating ? (vm.upperFlexHeight * 5) : (vm.setUpperFlexHeight * 5))
                    }
                    Text("\(String(format: "%.1f", isUpperFlexUpdating ? vm.upperFlexHeight : vm.setUpperFlexHeight))º")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                    Button {
                        if isUpperFlexUpdating {
                            vm.finalizeUpperFlex()
                            isUpperFlexUpdating = false
                            if let user = user {
                                user.upperFlex = vm.setUpperFlexHeight
                                do {
                                    try modelContext.save()
                                } catch {
                                    print("Error saving user data: \(error)")
                                }
                            }
                        } else {
                            isUpperFlexUpdating = true
                        }
                    } label: {
                        Text(isUpperFlexUpdating ? "Set" : "Update")
                            .font(.system(size: 17, weight: .black))
                            .fontWidth(.expanded)
                            .padding()
                            .foregroundStyle(.white)
                            .background(isUpperFlexUpdating ? .blue : .black)
                            .padding(.top, 17)
                    }
                }
                //lower-Flex
                VStack(spacing: 12) {
                    Text("Lower")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                        .padding(.bottom)
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .frame(width: 65, height: 280)
                            .opacity(0.2)
                        Rectangle()
                            .foregroundStyle(.cyan)
                            .frame(width: 65, height: isLowerFlexUpdating ? (vm.lowerFlexHeight * 5) : (vm.setLowerFlexHeight * 5))
                    }
                    Text("\(String(format: "%.1f", isLowerFlexUpdating ? vm.lowerFlexHeight : vm.setLowerFlexHeight))º")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                    Button {
                        if isLowerFlexUpdating {
                            vm.finalizeLowerFlex()
                            isLowerFlexUpdating = false
                            if let user = user {
                                user.lowerFlex = vm.setLowerFlexHeight
                                do {
                                    try modelContext.save()
                                } catch {
                                    print("Error saving user data: \(error)")
                                }
                            }
                        } else {
                            isLowerFlexUpdating = true
                        }
                    } label: {
                        Text(isLowerFlexUpdating ? "Set" : "Update")
                            .font(.system(size: 17, weight: .black))
                            .fontWidth(.expanded)
                            .padding()
                            .foregroundStyle(.white)
                            .background(isLowerFlexUpdating ? .cyan : .black)
                            .padding(.top, 17)
                    }
                }
            }
            .padding(.bottom, 90)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .onAppear() {
            if user == nil {
                modelContext.insert(User.defaultUser)
                do {
                    try modelContext.save()
                    print("New User created!")
                } catch {
                    print("Err creating default user")
                }
            } else {
                print("User found!")
                vm.setUpperFlexHeight = user?.upperFlex ?? 0
                vm.setLowerFlexHeight = user?.lowerFlex ?? 0
            }
        }
        .onChange(of: manager.latestSensorData, { _, _ in
            vm.SetUpUpperFlex(manager.latestSensorData)
            vm.SetUpLowerFlex(manager.latestSensorData)
        })
        .animation(.easeInOut, value: isUpperFlexUpdating)
        .animation(.easeInOut, value: isLowerFlexUpdating)
    }
}

#Preview {
    FlexSettingsScreen()
}
