//
//  FlexSenseMVPApp.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/8/25.
//

import SwiftUI
import SwiftData

@main
struct FlexSenseMVPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self])
        }
    }
}
