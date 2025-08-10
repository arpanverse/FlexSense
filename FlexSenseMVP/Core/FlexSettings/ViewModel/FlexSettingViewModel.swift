//
//  FlexSettingViewModel.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/10/25.
//

import Foundation

class FlexSettingViewModel: ObservableObject {
    static let shared = FlexSettingViewModel()
    
    @Published var setUpperFlexHeight: Double = 0
    @Published var setLowerFlexHeight: Double = 0
    
    @Published var upperFlexHeight: Double = 0
    @Published var lowerFlexHeight: Double = 0
    
    func SetUpUpperFlex(_ data: String) {
        let flex1Value = Double(data.split(separator: ",")[0]) ?? 0
        let value = ((flex1Value - 30) * 1.2)
        if value < 0 {
            upperFlexHeight = 0
        } else {
            upperFlexHeight = value
        }
    }
    
    func SetUpLowerFlex(_ data: String) {
        let flex2Value = Double(data.split(separator: ",")[1]) ?? 0
        let value = ((flex2Value - 6) * 0.9) - 5
        if value < 0 {
            lowerFlexHeight = 0
        } else {
            lowerFlexHeight = value
        }
    }
    
    func finalizeUpperFlex() {
        setUpperFlexHeight = upperFlexHeight
        if setUpperFlexHeight < 0 {
            setUpperFlexHeight = 0
        }
    }
    
    func finalizeLowerFlex() {
        setLowerFlexHeight = lowerFlexHeight
        if setLowerFlexHeight < 0 {
            setLowerFlexHeight = 0
        }
    }
}
    
