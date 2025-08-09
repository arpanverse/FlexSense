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
        upperFlexHeight = ((flex1Value - 100) * 0.225) - 4
    }
    
    func SetUpLowerFlex(_ data: String) {
        let flex2Value = Double(data.split(separator: ",")[1]) ?? 0
        lowerFlexHeight = ((flex2Value) * 0.225) - 7
    }
    
    func finalizeUpperFlex() {
        setUpperFlexHeight = upperFlexHeight
    }
    
    func finalizeLowerFlex() {
        setLowerFlexHeight = lowerFlexHeight
    }
}
    
