//
//  UserModel.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/10/25.
//

import Foundation
import SwiftData

@Model
class User {
    var id = UUID()
    var upperFlex: Double
    var lowerFlex: Double
    
    init(id: UUID = UUID(), upperFlex: Double, lowerFlex: Double) {
        self.id = id
        self.upperFlex = upperFlex
        self.lowerFlex = lowerFlex
    }
}

extension User {
    static let defaultUser: User =
        .init(upperFlex: 12, lowerFlex: 14)
}
