//
//  FlexSettingsScreen.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/10/25.
//

import SwiftUI
import SwiftData

struct FlexSettingsScreen: View {
    @Query var users: [User]
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
            Text("Set Critical \nFlex Values ")
                .font(.system(size: 32, weight: .black))
                .fontWidth(.expanded)
            Text("Personalize according to your \ncomfort level.")
                .font(.system(size: 15, weight: .medium))
                .opacity(0.5)
                .padding(.top, 4)
            Spacer()
            HStack(spacing: 36) {
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
                            .frame(width: 65, height: 90)
                    }
                    Text("\(30)º")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                    Button {
                        if isUpperFlexUpdating {
                            isUpperFlexUpdating = false
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
                            .frame(width: 65, height: 145)
                    }
                    Text("\(65)º")
                        .font(.system(size: 17, weight: .black))
                        .fontWidth(.expanded)
                    Button {
                        if isLowerFlexUpdating {
                            isLowerFlexUpdating = false
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
        .animation(.easeInOut, value: isUpperFlexUpdating)
        .animation(.easeInOut, value: isLowerFlexUpdating)
    }
}

#Preview {
    FlexSettingsScreen()
}
